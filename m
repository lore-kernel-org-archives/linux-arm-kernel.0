From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 17:19:26 -0300
Subject: [PATCH 4/4] pinctrl: mvebu: add missing iounmap
In-Reply-To: <CACRpkdZKGUGnnwEt0W6hQKhA0NnHWtkeBuaz-chDS=9rZD9y7A@mail.gmail.com>
References: <1377175611-4241-1-git-send-email-jszhang@marvell.com>
 <1377175611-4241-5-git-send-email-jszhang@marvell.com>
 <20130822132207.GA27167@localhost>
 <CACRpkdZKGUGnnwEt0W6hQKhA0NnHWtkeBuaz-chDS=9rZD9y7A@mail.gmail.com>
Message-ID: <20130823201925.GA2417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 08:06:02PM +0200, Linus Walleij wrote:
> On Thu, Aug 22, 2013 at 3:22 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > On Thu, Aug 22, 2013 at 08:46:51PM +0800, Jisheng Zhang wrote:
> >> Add missing iounmap to prove error path and remove path
> >>
> >> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> >> ---
> >>  drivers/pinctrl/mvebu/pinctrl-mvebu.c | 24 +++++++++++++++++-------
> >>  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > How about using devm_ioremap_resource() instead?
> 
> Yeah that's the right solution, Jisheng can you fix this?
> 

I think he already did that, there's a v2 floating around
with such change. I plan to give it a test, maybe tomorrow,
if I can find some spare time.

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
