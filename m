From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 21:09:00 -0700
Subject: [GIT PULL] CSR SiRFmarco preparing patches
In-Reply-To: <CAGsJ_4xY17w96vVs1966KJBC5Tt24qyR=YAPbQWMTFrDRs+xog@mail.gmail.com>
References: <CAGsJ_4xY17w96vVs1966KJBC5Tt24qyR=YAPbQWMTFrDRs+xog@mail.gmail.com>
Message-ID: <20120905040900.GA6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 05:35:42PM +0800, Barry Song wrote:
> Hi Olof, Arnd,
> 
> Please pull the following patches which are making mach-prima2 common
> for prima2 and coming new marco SoC.
> Note the 3/5 patches depend on 2/5:
> ARM: PRIMA2: convert to common clk and finish full clk tree
> clk: prima2: move from arch/arm/mach to drivers/clk
> which have been in Mike's clk-next, you might see:
> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=shortlog;h=refs/heads/clk-next
> 
> so i rebase other 3 patches on top of commit
> bc0e489eb07f4aa2fb5cb9b7ff1fdf4b6ba3bda5.
> 
> i guess Mike will not rebase prima2 clk patches any more, so there
> will not be merge conflict.
> 
> anyway, if i have let prima2-clk go through arm-soc tree but not clk
> tree, things should be better.
> 
> Regards,
> Barry
> 
> The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> 
>   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> 
> are available in the git repository at:
>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git marco-prepare

Thanks, pulled into next/cleanup. Mike, speak up if you anticipate need to
rebuild your branch and thus rebase the two patches pulled in.


-Olof
