From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:45:06 -0800
Subject: [GIT PULL] DaVinci additional driver support for v4.10
In-Reply-To: <fc11bfc7-e218-cd11-8e4e-c48e899d1cb5@ti.com>
References: <fc11bfc7-e218-cd11-8e4e-c48e899d1cb5@ti.com>
Message-ID: <20161118074506.GR1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 06:28:22PM +0530, Sekhar Nori wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/drivers
> 
> for you to fetch changes up to 8e7223fc8626db7c302136747bb68213100d290c:
> 
>   bus: davinci: add support for da8xx bus master priority control (2016-11-14 17:20:29 +0530)
> 
> ----------------------------------------------------------------
> This pull request adds two new drivers for better
> support for LCD found on DaVinci DA8xx devices.
> 
> They allow configuration of memory interface and
> bus priorities on the SoC to allow sufficient
> bandwidth for the LCD and prevent underruns.
> 
> The DT bindings have been reviewed by Rob and
> patches have been reviewed by Kevin.
> 
> ----------------------------------------------------------------
> Bartosz Golaszewski (2):
>       memory: davinci: add support for da8xx DDR2/mDDR controller
>       bus: davinci: add support for da8xx bus master priority control

Merged, thanks!


-Olof
