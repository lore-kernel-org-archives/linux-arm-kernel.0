From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 Nov 2016 12:23:08 -0800
Subject: [GIT PULL 2/4] DaVinci SoC updates for v4.10
In-Reply-To: <20161104062535.9593-2-nsekhar@ti.com>
References: <20161104062535.9593-1-nsekhar@ti.com>
 <20161104062535.9593-2-nsekhar@ti.com>
Message-ID: <20161108202308.GI2106@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 11:55:33AM +0530, Sekhar Nori wrote:
> The following changes since commit 766763dbdc1dca11deabdb00077a1c19e2803f0a:
> 
>   ARM: davinci: da8xx: Remove duplicated defines (2016-10-31 16:51:56 +0530)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/soc
> 
> for you to fetch changes up to ced95ac0815501f47a6041548d70d8900400912d:
> 
>   ARM: davinci: da8xx: register USB PHY clocks in the DT file (2016-11-01 15:24:24 +0530)
> 
> ----------------------------------------------------------------
> DaVinci SoC support improvements mainly towards an effort to
> get to working USB support.
> 
> - use CFGCHIP syscon device to access common registers
> 
> - define platform data and device tree nodes for newly
>   introduced USB phy driver
> 
> - clock lookup and auxdata lookup for USB phy and also
>   for LCDC (LCD controller)

Merged, thanks.


-Olof
