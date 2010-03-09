From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 9 Mar 2010 09:41:14 +0200
Subject: [PATCH v3] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <7859d1571b6d772a9976ca3d53f8ee0e9851bb38.1265099368.git.baruch@tkos.co.il>
References: <20100202092220.26869dc4@linux.lan.towertech.it>
	<7859d1571b6d772a9976ca3d53f8ee0e9851bb38.1265099368.git.baruch@tkos.co.il>
Message-ID: <20100309074114.GA3104@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

On Tue, Feb 02, 2010 at 10:33:03AM +0200, Baruch Siach wrote:
> This driver is based on code from Freescale which accompanies their i.MX25 PDK
> board, with some cleanup.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/rtc/Kconfig     |   10 +
>  drivers/rtc/Makefile    |    1 +
>  drivers/rtc/rtc-imxdi.c |  520 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 531 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-imxdi.c

Ping?

Since .34-rc1 has already been released, I guess this is not going to get into 
2.6.34. Are there any remaining issues to resolve in order to merge this 
upstream?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
