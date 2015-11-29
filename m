From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Nov 2015 22:28:59 +0100
Subject: [PATCH 2/3] ste_dma40: Delete another unnecessary check in
 d40_probe()
In-Reply-To: <564A4996.2000406@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <564A4899.8040109@users.sourceforge.net>
 <564A4996.2000406@users.sourceforge.net>
Message-ID: <CACRpkdZ=NkrmuZpq8YtseFxBB8g2Nc2ae231PjO+-c0+jd+GDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 10:24 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 16 Nov 2015 21:56:07 +0100
>
> A single jump label was used by the d40_probe() function in several cases
> for error handling which was a bit inefficient here.
>
> * This implementation detail could be improved by the introduction
>   of another jump label.
>
> * Remove an extra check for the variable "base".
>
> * Omit its explicit initialisation at the beginning then.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
