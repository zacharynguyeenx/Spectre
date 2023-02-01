import Foundation

enum Stubs {
    static let gstIcon = "https://s2.coinmarketcap.com/static/img/coins/64x64/16352.png"
    static let usdcIcon = "https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png"

    static let jupiterIcon = "https://pbs.twimg.com/profile_images/1609874776151183362/T1eJXDui_400x400.png"

    static let usdcAddress = "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v"
    static let gstAddress = "AFbX8oGjGpmVFywbVouvhQSRmiW2aR1mohfahi4Y2AdB"
    static let solAddress = "So11111111111111111111111111111111111111112"
    static let sbrAddress = "Saber2gLauYim4Mvftnrasomsv6NvAuncvMEZwcLpD1"
    static let mngoAddress = "MangoCzJ36AjZyKwVj3VnYU4GTonjfVEnJmvvWaxLac"

    static let activities: [Activity] = [
        .init(
            transactionType: .swap,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [
                .init(tokenAddress: Stubs.gstAddress, tokenSymbol: "GST", tokenIcon: Stubs.gstIcon, amount: -158.04999),
                .init(tokenAddress: Stubs.usdcAddress, tokenSymbol: "USDC", tokenIcon: Stubs.usdcIcon, amount: 3.68146)
            ],
            isSuccess: true,
            fee: 0.000005,
            provider: "Jupiter",
            providerIcon: Stubs.jupiterIcon,
            timestamp: Date()
        ),
        .init(
            transactionType: .transferFungible,
            senderAddress: "",
            receiverAddress: "0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B",
            fungibleTokenTransfers: [
                .init(tokenAddress: Stubs.usdcAddress, tokenSymbol: "USDC", tokenIcon: Stubs.usdcIcon, amount: -29.52355)
            ],
            isSuccess: true,
            fee: 0.000005,
            provider: nil,
            timestamp: Date().addingTimeInterval(-86400)
        ),
        .init(
            transactionType: nil,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [],
            isSuccess: false,
            fee: 0.000005,
            provider: "Jupiter",
            timestamp: Date().addingTimeInterval(-86400-1)
        ),
        .init(
            transactionType: nil,
            senderAddress: "",
            receiverAddress: "",
            fungibleTokenTransfers: [],
            isSuccess: true,
            fee: 0.000005,
            provider: nil,
            timestamp: Date().addingTimeInterval(-86400*2)
        ),
        .init(
            transactionType: .transferFungible,
            senderAddress: "0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B",
            receiverAddress: "",
            fungibleTokenTransfers: [
                .init(tokenAddress: Stubs.gstAddress, tokenSymbol: "GST", tokenIcon: Stubs.gstIcon, amount: 36.19998)
            ],
            isSuccess: true,
            fee: 0.000005,
            provider: nil,
            timestamp: Date().addingTimeInterval(-86400*2-1)
        ),
    ]
}
