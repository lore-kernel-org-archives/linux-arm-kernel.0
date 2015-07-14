From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 09:57:52 +0200
Subject: [PATCH 3/4] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <1434743950-7771-3-git-send-email-aalonso@freescale.com>
References: <1434743950-7771-1-git-send-email-aalonso@freescale.com>
 <1434743950-7771-3-git-send-email-aalonso@freescale.com>
Message-ID: <CACRpkdYt227EmLW3SngChp-mHd4TO38W2FswCZRar-MET7dztw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 9:59 PM, Adrian Alonso <aalonso@freescale.com> wrote:

> * Extend pinctrl-imx driver to support iomux lpsr conntroller,
> * iMX7D has two iomuxc controllers, iomuxc controller similar as
>   previous iMX SoC generation and iomuxc-lpsr which provides
>   low power state rentetion capabilities on gpios that are part of
>   iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0).
> * Use IOMUXC_LPSR_SUPPORT and iput_val most significant bits to
>   properly configure iomuxc/iomuxc-lpsr settings.
>
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

I'm waiting for Shawn's ACK on this before I do anything, and you also
need to address Zhi Li's comments. (Or there is already such
a version higher up in my mailbox, in that case, sorry.)

Yours,
Linus Walleij
