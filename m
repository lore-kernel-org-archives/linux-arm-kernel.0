From: horms@verge.net.au (Simon Horman)
Date: Fri, 12 Oct 2018 13:19:27 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77990: Add DMA properties to
 MSIOF nodes
In-Reply-To: <CAMuHMdUhEt87dggNbZHjsDu0ZVjOSxbaZBDbA4nND+e_3o40tQ@mail.gmail.com>
References: <1539070730-20349-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdUhEt87dggNbZHjsDu0ZVjOSxbaZBDbA4nND+e_3o40tQ@mail.gmail.com>
Message-ID: <20181012111926.5fgzedqv7rp7z625@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 02:39:18PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 9, 2018 at 9:39 AM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > This patch adds DMA properties to the MSIOF device nodes of R8A77990 SoC.
> >
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> on Ebisu using a 25LC040 EEPROM
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/arch/arm64/boot/dts/renesas/r8a77990-ebisu-cn41-msiof0-25lc040.dtso?h=topic/renesas-overlays

Thanks, applied for v4.21.
