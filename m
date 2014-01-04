From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jan 2014 21:55:12 -0800
Subject: [GIT PULL] Integrator changes for v3.14
In-Reply-To: <CACRpkdZ-rmWkNk_fkx_U78_fHQRRX=e64J0eXx1Y0UtetYD91A@mail.gmail.com>
References: <CACRpkdZ-rmWkNk_fkx_U78_fHQRRX=e64J0eXx1Y0UtetYD91A@mail.gmail.com>
Message-ID: <20140104055512.GB6243@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 03, 2014 at 10:35:36PM +0100, Linus Walleij wrote:
> Hi ARM SoC guys,
> 
> here are a few patches that have matured for the Integrators.
> I have opted not to split these across branches as I don't think
> there will be much more for this merge window.
> 
> irqchip patch is ACKed by TGLX, the clk stuff is ACKed by
> Mike Turquette.
> 
> Please pull this into ARM SoC!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:
> 
>   Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/integrator-for-v3.14
> 
> for you to fetch changes up to 8e048b9997efbe75fe77b1f14d3af41700cc8724:
> 
>   clk: versatile: fixup IM-PD1 clock implementation (2014-01-03 22:27:54 +0100)


I've merged this branch into next/drivers, since most of the changes were
to drivers or dt.


-Olof
