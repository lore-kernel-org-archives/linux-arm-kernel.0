From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Apr 2013 21:37:46 +0200
Subject: [PATCH v11 0/3] Another round of ARMv7-M patches
In-Reply-To: <516EDEDA.1000108@arm.com>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <516EDEDA.1000108@arm.com>
Message-ID: <20130417193746.GR30416@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Apr 17, 2013 at 06:41:46PM +0100, Jonathan Austin wrote:
> The only comment I have left is that I'd really like the
> BASEADDRESS_V7M_SCB namespaced like the rest of the V7M defines
The idea behind this naming is that V7M_SCB_BASEADDRESS is in the same
namespace as V7M_SCB_CPUID so I opened a new namespace for base
addresses. Don't you like it only because it's new? Do others have
thoughts here?

> With that said, please feel free to add for the series:
> 
> Reviewed-by: Jonathan Austin <jonathan.austin@arm.com>
> Tested-by: Jonathan Austin <jonathan.austin@arm.com
Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
