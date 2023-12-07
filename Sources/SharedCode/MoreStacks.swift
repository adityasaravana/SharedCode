//
//  MoreStacks.swift
//
//
//  Created by NMS15065-8-adisara on 12/5/23.
//

import Foundation
import SwiftUI

struct LStack<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        HStack {
            content
            Spacer()
        }
    }
}

struct RStack<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        HStack {
            Spacer()
            content
        }
    }
}

struct TStack<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        VStack {
            content
            Spacer()
        }
    }
}

struct BStack<Content: View>: View {
    @ViewBuilder let content: Content
    var body: some View {
        VStack {
            Spacer()
            content
        }
    }
}

#Preview {
    VStack {
        LStack(content: { Text("fff") })
        RStack(content: { Text("fff") })
        BStack(content: { Text("fff") })
        TStack(content: { Text("fff") })
    }.frame(width: 300, height: 300)
}
