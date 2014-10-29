From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Oct 2014 18:31:20 +0100
Subject: [PATCH] pinctrl: at91: use own header
In-Reply-To: <CAMAWPa_RuU73bPkxOwiqYjW3nH1DSCX+fOQ12T63SLiOVEBnyw@mail.gmail.com>
References: <1413539380-7046-1-git-send-email-alexandre.belloni@free-electrons.com>
 <CACRpkdbkVXCtaVY1S24bZ-q8vam729p0seGvvpKOL-AQQMywTQ@mail.gmail.com>
 <CAMAWPa_RuU73bPkxOwiqYjW3nH1DSCX+fOQ12T63SLiOVEBnyw@mail.gmail.com>
Message-ID: <20141029173119.GB17398@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,


On 29/10/2014 at 10:17:56 -0700, Kevin Hilman wrote :
> On Tue, Oct 28, 2014 at 9:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Oct 17, 2014 at 11:49 AM, Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> wrote:
> >
> >> Copy the mach/at91_pio.h header locally and use it for pinctrl-at91.c. This
> >> allows to remove the dependency on mach/at91_pio.h to be able to move at91 to
> >> multiplatform.
> >>
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >
> > Patch applied to the pinctrl tree with Nicolas' ACK.
> 
> This patch broke the build for sama5_defconfig in next-20141029[1], as
> well as the other at91*defconfigs.
> 

It should be solved by now, the fix as been squashed in the offending
commit.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
