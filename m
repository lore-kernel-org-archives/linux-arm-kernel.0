From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 17 May 2013 10:51:00 +0200
Subject: [PATCH] can: flexcan: allow compilation on arm and powerpc
In-Reply-To: <20130517020351.GE3893@S2101-09.ap.freescale.net>
References: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
 <20130517020351.GE3893@S2101-09.ap.freescale.net>
Message-ID: <5195EF74.8070005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2013 04:03 AM, Shawn Guo wrote:
> Hi Marc,
> 
> On Thu, May 16, 2013 at 03:42:36PM +0200, Marc Kleine-Budde wrote:
>> This patch removes the Kconfig symbols HAVE_CAN_FLEXCAN and
>> IMX_HAVE_PLATFORM_FLEXCAN from arch/{arm,powerpc} and allowing compilation on
>> all arm and powerpc platforms.
> 
> I'm generally fine with the approach.  But with Kconfig symbol
> IMX_HAVE_PLATFORM_FLEXCAN removed, how does the build of
> platform-flexcan.o work?
> 
> arch/arm/mach-imx/devices/Makefile:obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o

Doh! - I've removed too much, will change.

Tnx,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/5c5bfc2f/attachment-0001.sig>
