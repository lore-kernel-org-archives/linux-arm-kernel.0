From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Aug 2017 15:24:08 +0800
Subject: [linux-sunxi] [PATCH v2 3/3] arm64: allwinner: a64: add proper
 support for the Wi-Fi on BPi M64
In-Reply-To: <20170725124504.40242-3-icenowy@aosc.io>
References: <20170725124504.40242-1-icenowy@aosc.io>
 <20170725124504.40242-3-icenowy@aosc.io>
Message-ID: <CAGb2v64ME+t8nwhkMFExH=40Q-xKxOPssGXkKx6JSQXkBj5Khw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 8:45 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> BPi M64 has an AP6212 Wi-Fi/Bluetooth combo module, and the Wi-Fi SDIO
> card is connected to the mmc1 controller.
>
> The pwrseq of the mmc1 (used to reset the card) used to missing, and the
> out-of-band interrupt line of the card is not specified.
>
> Fix these issues for proper Wi-Fi support of BPi M64.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied for 4.14.

Thanks.
