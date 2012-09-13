From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Sep 2012 22:48:54 -0700
Subject: [GIT PULL 1/4] mxs device tree changes for 3.7
In-Reply-To: <1347350100-4674-2-git-send-email-shawn.guo@linaro.org>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
 <1347350100-4674-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120913054854.GE24290@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:54:56PM +0800, Shawn Guo wrote:
> The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:
> 
>   Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.7
> 
> for you to fetch changes up to 13b4569bbbcf58891727138b84b8db5ea4178d32:
> 
>   ARM: dts: cfa10049: Add the 74HC595 gpio expanders (2012-09-11 09:51:30 +0800)
> 
> ----------------------------------------------------------------
> mxs-dt-3.7
> 
> - Remove all board files and make mach-mxs a DT-only platform
> - Some dts file formatting and style fixing
> - DTS update for additional boards and devices

\o/  Nice work! Good to see another platform go fully DT-probed.

Pulled in as mxs/dt into next/dt.

Only nit is that you don't need to add the tag name to the tag description
in the future. I took it out when merging, and it's no big deal and easy
to do.


-Olof
