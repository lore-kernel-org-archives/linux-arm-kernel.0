From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 9 Nov 2015 12:17:39 +0800
Subject: [PATCH v3 2/3] ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of
 reg_vcc3v0
In-Reply-To: <1446832486-32319-3-git-send-email-plaes@plaes.org>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
 <1446832486-32319-3-git-send-email-plaes@plaes.org>
Message-ID: <CAGb2v64THR9b42G4M-p+hN6vARLVvQxhHFk=_wAM7E80ZK5Uzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 7, 2015 at 1:54 AM, Priit Laes <plaes@plaes.org> wrote:
> ADC seems to be using ldo2 for reference voltage.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>

I assume this is from some reference design and there is no way to actually
confirm it without exact schematics? There's no mention of it in the FEX file.
If so you should probably expand the commit message to include the source of
such an assumption.

> ---
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
