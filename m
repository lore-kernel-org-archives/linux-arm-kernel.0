From: ben@fluff.org (root)
Date: Fri, 28 Jan 2011 14:12:16 +0000
Subject: [RFC] add pwmlib support
In-Reply-To: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110128141216.GA6374@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 01:21:21PM +0100, Sascha Hauer wrote:
> Hi all,
> 
> While implementing just another pwm driver I thought it's time to implement
> generic pwm support. The following series adds drivers/pwm/pwmlib.c and
> a i.MX23/28 pwm driver which serves as a usage example for pwmlib. The
> code is inspired by gpiolib support and tested using the backlight pwm
> driver by Eric Miao.

You know, I really wish driver cores like this where not called lib... it
is hardly as if they can be taken out of the kernel and usefully re-used
in another project.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
