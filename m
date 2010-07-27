From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 27 Jul 2010 08:09:12 +0300
Subject: Pull request mxc
In-Reply-To: <20100726090014.GQ14113@pengutronix.de>
References: <20100726090014.GQ14113@pengutronix.de>
Message-ID: <20100727050911.GA22765@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Jul 26, 2010 at 11:00:14AM +0200, Sascha Hauer wrote:
> Please pull the following patches for 2.6.36.

I'm using this opportunity to ask about the verdict of the "arm/imx/gpio: add 
spinlock protection" patch that I posted on July, 6. As I mentioned since this 
fixes a potential GPIO register corruption, this is should go in before .36.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
