From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Nov 2011 16:06:09 +0100
Subject: [PATCH 1/2] ARM: mx28evk: remove flexcan_pdata __initconst
 attribute
In-Reply-To: <1321024360-5249-1-git-send-email-b29396@freescale.com>
References: <1321024360-5249-1-git-send-email-b29396@freescale.com>
Message-ID: <20111111150609.GD5011@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 11:12:39PM +0800, Dong Aisheng wrote:
> The flexcan driver still uses it after init.
As "it" is a copy of flexcan_pdata it's completely OK for the driver to
use it.

What is the exact problem you want to address?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
