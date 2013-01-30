From: Barry.Song@csr.com (Barry Song)
Date: Wed, 30 Jan 2013 03:11:16 +0000
Subject: [GIT PULL] CSR SiRFmarco SoC infrastructures for 3.9
In-Reply-To: <CAOesGMgHpEaR4Hxjw1esMbqvvpRA5_rDE=ahKunwJ70FDJmNKQ@mail.gmail.com>
References: <CAGsJ_4z-7z8=3xQwU6iEsqHEcVrRWK+Fm7eoBEbjC-EAewGypA@mail.gmail.com>
 <20130128070848.GG25723@quad.lixom.net>
 <CAGsJ_4yV5KJ2yWQtbOLO5Dj_MrQS3v0sPN4hinJAzTsfH6quvg@mail.gmail.com>
 <20130129165110.GA16188@quad.lixom.net>
 <CAOesGMgHpEaR4Hxjw1esMbqvvpRA5_rDE=ahKunwJ70FDJmNKQ@mail.gmail.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E90122B8D3A7@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Wednesday, January 30, 2013 3:04 AM
> To: Barry Song
> Cc: Arnd Bergmann; linux-arm-kernel at lists.infradead.org;
> DL-SHA-WorkGroupLinux
> Subject: Re: [GIT PULL] CSR SiRFmarco SoC infrastructures for 3.9
> 
> On Tue, Jan 29, 2013 at 8:51 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Mon, Jan 28, 2013 at 06:08:27PM +0800, Barry Song wrote:
> >> 2013/1/28 Olof Johansson <olof@lixom.net>:
> >> > On Thu, Jan 24, 2013 at 11:21:02AM +0800, Barry Song wrote:
> >> >> Hi Olof, Arnd,
> >> >>
> >> >> pls pull the following changes for CSR SiRFmarco SoC. it has been
> >> >> rebased againest arm-soc timer/cleanup tree.
> >> >>
> >> >> since commit 90cf214d6a549bf482e3c5751ee256cc885b96ea:
> >> >>
> >> >>   ARM: at91: fix board-rm9200-dt after sys_timer conversion
> >> >> (2013-01-14 10:14:04 -0800)
> >> >>
> >> >> are available in the git repository at:
> >> >>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
> >> >> marco-timer-cleanup-rebase
> >> >
> >> > Pulled in as prima2/marco, included in next/soc. Thanks!
> >>
> >> Olof, thanks.
> >>
> >> >
> >> > I noticed that there is no defconfig for any mach-prima2 platforms. Feel
> >> > free to submit one so we get build coverage of the platform.
> >>
> >> there have been. arch/arm/configs/prima2_defconfig
> >
> > Ah, it enables ARCH_SIRF, I was searching for ARCH_PRIMA2 or
> ARCH_MARCO. Good.
> 
> ..and it's broken due to interaction with the gic-vic move. :(
> 
> Barry, can you please follow up with a patch to do the corresponding
> changes for prima?

Ok. I'll take care.
> 
> 
> Thanks,
> 
> -Olof
> 
-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
