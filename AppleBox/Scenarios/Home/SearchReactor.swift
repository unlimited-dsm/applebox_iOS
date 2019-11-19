//
//  SearchReacotr.swift
//  AppleBox
//
//  Created by leedonggi on 2019/11/18.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import ReactorKit
import RxSwift

class SearchReactor: Reactor {
    enum Action {
        case typing
    }
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    struct State {
        var isLoading: Bool
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
          isLoading: false
        )
    }
    
    func mutate(action: SearchReactor.Action) -> Observable<SearchReactor.Mutation> {
        switch action {
        case .typing:
            return Observable.concat([
              Observable.just(Mutation.setLoading(true)),
              Observable.just(Mutation.setLoading(false)).delay(.milliseconds(500), scheduler: MainScheduler.instance)
            ])
        }
    }
    
    func reduce(state: SearchReactor.State, mutation: SearchReactor.Mutation) -> SearchReactor.State {
        var state = state
        switch mutation {
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
