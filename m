From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 9 Mar 2010 12:34:36 +0200
Subject: [rtc-linux] Re: [PATCH v3] rtc: driver for the DryIce block
	found in  i.MX25 chips
In-Reply-To: <20100309112146.71202332@linux.lan.towertech.it>
References: <20100202092220.26869dc4@linux.lan.towertech.it>
	<7859d1571b6d772a9976ca3d53f8ee0e9851bb38.1265099368.git.baruch@tkos.co.il>
	<20100309074114.GA3104@jasper.tkos.co.il>
	<20100309112146.71202332@linux.lan.towertech.it>
Message-ID: <20100309103436.GB25634@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

On Tue, Mar 09, 2010 at 11:21:46AM +0100, Alessandro Zummo wrote:
> On Tue, 9 Mar 2010 09:41:14 +0200 Baruch Siach <baruch@tkos.co.il> wrote:
> > Ping?
> > 
> > Since .34-rc1 has already been released, I guess this is not going to get into 
> > 2.6.34. Are there any remaining issues to resolve in order to merge this 
> > upstream?
> 
>  I just have to find some time to review it. don't worry, since is a completely
>  new driver it could go upstream at any time.

Thanks. Please note another patch against this one fixing an irq related bug:

http://groups.google.com/group/rtc-linux/browse_thread/thread/2847baa17905dfc3#

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
