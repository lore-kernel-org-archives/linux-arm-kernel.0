From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 15:20:15 -0800
Subject: [GIT PULL] Nomadik devicetree and cleanups
In-Reply-To: <CACRpkdaVOV4d9xeuKnMyfGgM+Su3M6dmo2pyeEQE9Qb2sErzzA@mail.gmail.com>
References: <CACRpkdZM8+6QaGrRtCCMWoZQO23uej7JDr1xz2zG7TtwQ7Ngqw@mail.gmail.com>
 <20130128213135.GA3047@quad.lixom.net>
 <CACRpkdaHo_xLwqUDF9C71HbuGEcJHg_Jrsf0gCSPYXa4E+yJGA@mail.gmail.com>
 <20130129173641.GA17935@quad.lixom.net>
 <CACRpkdaVOV4d9xeuKnMyfGgM+Su3M6dmo2pyeEQE9Qb2sErzzA@mail.gmail.com>
Message-ID: <20130131232015.GA3314@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 11:21:06PM +0100, Linus Walleij wrote:
> On Tue, Jan 29, 2013 at 6:36 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Mon, Jan 28, 2013 at 11:36:59PM +0100, Linus Walleij wrote:
> >> On Mon, Jan 28, 2013 at 10:31 PM, Olof Johansson <olof@lixom.net> wrote:
> >>
> >> > Would you mind rebasing on top of the depends/cleanup branch in arm-soc, sort
> >> > out the breakage (and test it) and resubmit?
> >>
> >> So Olof, please try this instead, based on the ARM depends/cleanup HEAD
> >> when I fetched it:
> >>
> >> The following changes since commit f8060f5446b1f2782f0a8ca9be2d870ea4198aee:
> >>
> >>   Merge tag 'gic-vic-to-irqchip' of
> >> git://sources.calxeda.com/kernel/linux into next/cleanup (2013-01-14
> >> 19:55:03 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> >> tags/nmk-dt-on-cleanups
> >
> > Beautiful! Pulled. Zero conflicts. :)
> 
> So as I heard this blew up for selecting OF instead of USE_OF here
> is yet another pull request, with this oneliner change in the relevant
> patch ("ARM: nomadik: delete old board files"):
> 
> - select OF
> + select USE_OF
> 
> I have tried to provoke builderrors with the defconfig but couldn't.
> 
> Here is then yet another pull request, and let's hope it works this
> time around:

Dropping and replacing branches is awkward, and you rewrote history here. It'd
be better to just take a fixup patch on top that switches the two selects.


-Olof
