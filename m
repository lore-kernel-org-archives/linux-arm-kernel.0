From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 May 2012 14:31:03 +0800
Subject: [GIT PULL] arch/arm/mach-* late_initcall cleanup
In-Reply-To: <CAAQ0ZWQ75tYxbnCHXW-WtDVLyFcf9WdvX=5MBiAOXD+ONrU8-g@mail.gmail.com>
References: <CAAQ0ZWQ75tYxbnCHXW-WtDVLyFcf9WdvX=5MBiAOXD+ONrU8-g@mail.gmail.com>
Message-ID: <20120505063101.GQ2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 11:27:48PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> Please pull the arch/arm/mach-* late_initcall cleanup series below.  I
> have collected acks from most of platform maintainers, and it may be
> the time to have them expose on linux-next to ensure they do not
> introduce any regression.
> 
> Regards,
> Shawn
> 
> ---
> 
> The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:
> 
>   Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/shawnguo/linux-2.6.git clean/late_initcall_v2
> 
I just updated the branch with one fixup from Sekhar applied, and the
Acked-by from Sekhar and Tony collected.

-- 
Regards,
Shawn
