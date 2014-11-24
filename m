From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Nov 2014 00:39:43 +0100
Subject: [PATCH v19 0/5] Rockchip soc thermal driver
In-Reply-To: <20141124201807.GA20404@developer>
References: <1416805142-27304-1-git-send-email-caesar.wang@rock-chips.com>
 <20141124201807.GA20404@developer>
Message-ID: <1771961.FfLxNDNiti@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Montag, 24. November 2014, 16:18:12 schrieb Eduardo Valentin:
> Hello Caesar,
> 
> On Mon, Nov 24, 2014 at 12:58:57PM +0800, Caesar Wang wrote:
> > This series patchs tested on rk3288 SDK board and pinky-v1,v2 board.
> > I believe the driver can be used on the rk3288-evb board.
> > 
> > Add this driver, The system will shutdown when
> > the thermal temperture over 100C.If for some reason we are unable to
> > shut it down in orderly fashion (kernel is stuck holding a lock or
> > similar)
> > then hardware will reset it.
> > 
> > The patchs 1/5,2/5 can applay Eduardo's Branch
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.g
> > it [branch "next-kernel"]
> > 
> > 	remote = origin
> > 	merge = refs/heads/next
> 
> I applied your patches 1 and 2 in my -linus branch, and luckily will be
> accepted for 3.19.

and I've taken patches 3, 4 and 5 into my dts branch for 3.19 .

I've adapted the commit messages in some places and removed the
	/* sensor		ID */
comments from the rk3288-thermal.dtsi.


Heiko
