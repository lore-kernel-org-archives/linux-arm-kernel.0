From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 May 2016 16:35:13 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160512122500.11411882@erd979>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
 <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
 <20160428092608.GE17159@lukather> <5723755D.9060108@ti.com>
 <20160509090615.6272f8ca@erd979>
 <CACRpkdbZmL9Cqp-ubzyxd7fWUFOVsS1DCxsfG02kSpbWu_rbZQ@mail.gmail.com>
 <20160509161728.3aee1134@erd979>
 <CACRpkdZwPVMx-dXVkfVwFN0juzVuyvShV7yDWbUFSXOPE=uUrw@mail.gmail.com>
 <20160512122500.11411882@erd979>
Message-ID: <CACRpkdYwtwosdCE_F5SEH9uwZRdJkAi-seL+nUrMFZ+w_esuVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 12:25 PM, Robin van der Gracht
<robin@protonic.nl> wrote:

> First half is completed. I've added myself as maintainer for the
> driver I've posted recently (HT16K33 LED CONTROLLER DRIVER).

Good!

> According to MAINTAINERS, Miguel maintains:
>  - CFAG12864B LCD DRIVER
>  - CFAG12864BFB LCD FRAMEBUFFER DRIVER
>  - KS0108 LCD CONTROLLER DRIVER
>  - AUXILIARY DISPLAY DRIVERS
>
> AFAIK, I should not be judge in Miguels case.

If patches come in for these drivers and Miguel still seem to be fallen
off the face of the earth I think you should ACK/merge patches for
these too, but deal with it when it happens.

> @linus: I'll send my patches to Greg if you agree on this.

We are in agreement.

Yours,
Linus Walleij
