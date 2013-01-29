From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 08:51:10 -0800
Subject: [GIT PULL] CSR SiRFmarco SoC infrastructures for 3.9
In-Reply-To: <CAGsJ_4yV5KJ2yWQtbOLO5Dj_MrQS3v0sPN4hinJAzTsfH6quvg@mail.gmail.com>
References: <CAGsJ_4z-7z8=3xQwU6iEsqHEcVrRWK+Fm7eoBEbjC-EAewGypA@mail.gmail.com>
 <20130128070848.GG25723@quad.lixom.net>
 <CAGsJ_4yV5KJ2yWQtbOLO5Dj_MrQS3v0sPN4hinJAzTsfH6quvg@mail.gmail.com>
Message-ID: <20130129165110.GA16188@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 06:08:27PM +0800, Barry Song wrote:
> 2013/1/28 Olof Johansson <olof@lixom.net>:
> > On Thu, Jan 24, 2013 at 11:21:02AM +0800, Barry Song wrote:
> >> Hi Olof, Arnd,
> >>
> >> pls pull the following changes for CSR SiRFmarco SoC. it has been
> >> rebased againest arm-soc timer/cleanup tree.
> >>
> >> since commit 90cf214d6a549bf482e3c5751ee256cc885b96ea:
> >>
> >>   ARM: at91: fix board-rm9200-dt after sys_timer conversion
> >> (2013-01-14 10:14:04 -0800)
> >>
> >> are available in the git repository at:
> >>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
> >> marco-timer-cleanup-rebase
> >
> > Pulled in as prima2/marco, included in next/soc. Thanks!
> 
> Olof, thanks.
> 
> >
> > I noticed that there is no defconfig for any mach-prima2 platforms. Feel
> > free to submit one so we get build coverage of the platform.
> 
> there have been. arch/arm/configs/prima2_defconfig

Ah, it enables ARCH_SIRF, I was searching for ARCH_PRIMA2 or ARCH_MARCO. Good.


-Olof
