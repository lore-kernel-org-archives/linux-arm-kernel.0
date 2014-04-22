From: jogo@openwrt.org (Jonas Gorski)
Date: Tue, 22 Apr 2014 15:49:52 +0200
Subject: [PATCH RESEND 4/5] ARM: BCM63XX: add BCM963138DVT Reference
 platform DTS
In-Reply-To: <1398130758-19456-5-git-send-email-f.fainelli@gmail.com>
References: <1398130758-19456-1-git-send-email-f.fainelli@gmail.com>
 <1398130758-19456-5-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAOiHx=mxDeAE0OMOr4dWN1g3_PbwNoJ-7UJ4x6PjeOWdP_hFdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 3:39 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Add a DTS file for the Broadcom BCM963138DVT reference platform board
> which leverages the bcm63138.dtsi SoC DTSi file.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile        |  3 +++
>  arch/arm/boot/dts/bcm63138dvt.dts | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm63138dvt.dts

Shouldn't the file be called bcm*9*63138dvt.dts, same as the board name?


Regards
Jonas
