From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Aug 2017 15:21:55 +0800
Subject: [linux-sunxi] [PATCH v2 2/3] arm64: allwinner: a64: enable AXP803
 for Banana Pi M64
In-Reply-To: <20170725124504.40242-2-icenowy@aosc.io>
References: <20170725124504.40242-1-icenowy@aosc.io>
 <20170725124504.40242-2-icenowy@aosc.io>
Message-ID: <CAGb2v67+h1bX8GeWEQpN2WEX-ip687OKagdJpS2C2C1gbXA_ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 8:45 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M64 board uses an AXP803 PMIC.
>
> Enable the PMIC and its regulators.
>
> As we have now proper regulators support, missing or dummy regulators
> are changed to the correct ones.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied for 4.14.

Thanks.
