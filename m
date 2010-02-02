From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 2 Feb 2010 10:29:03 +0200
Subject: [rtc-linux] [PATCH v3] rtc: driver for the DryIce block found
	in  i.MX25 chips
In-Reply-To: <20100202092220.26869dc4@linux.lan.towertech.it>
References: <20100201102057.4937155f@linux.lan.towertech.it>
	<f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265093096.git.baruch@tkos.co.il>
	<20100202092220.26869dc4@linux.lan.towertech.it>
Message-ID: <20100202082903.GD13952@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

On Tue, Feb 02, 2010 at 09:22:20AM +0100, Alessandro Zummo wrote:
> On Tue,  2 Feb 2010 08:47:04 +0200
> Baruch Siach <baruch@tkos.co.il> wrote:
> > 
> > Changes v2 -> v3:
> > 
> > Add spaces around the '+' operator as suggested by Alessandro Zummo and Lothar 
> > Wa?mann.
> > 
> > Address other comments of Alessandro Zummo:
> > 
> > 	* add implementation of the alarm_irq_enable rtc op
> > 	* use devres in .probe
> > 	* remove unneeded initializations
> 
>  I believe you sent the old version ;)

Oops. Sending again.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
