From: kvalo@codeaurora.org (Kalle Valo)
Date: Tue, 12 Jun 2018 13:58:10 +0300
Subject: [GIT PULL 2/4] ARM: Device-tree updates
In-Reply-To: <20180612000142.28883-3-olof@lixom.net> (Olof Johansson's message
 of "Mon, 11 Jun 2018 17:01:40 -0700")
References: <20180612000142.28883-1-olof@lixom.net>
 <20180612000142.28883-3-olof@lixom.net>
Message-ID: <87efhcb7b1.fsf@purkki.adurom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> - Qualcomm:
> + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
> (Cortex-A75/A55 derivative) SoC that's one of the current high-end
> mobile SoCs.
>
> It's great to see mainline support for it. So far, you
> can't do much with it, since a lot of peripherals are not yet in the
> DTs but driver support for USB, GPU and other pieces are starting to
> trickle in. This might end up being a well-supported SoC upstream if
> the momentum keeps up.

The wifi chip is called wcn3990 and we are working on supporting that in
ath10k. I'm hoping to get it ready for v4.19.

-- 
Kalle Valo
