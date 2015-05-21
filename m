From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 May 2015 10:26:04 +0200
Subject: [PATCH defconfig] ARM: add ARM_SINGLE_ARMV7M in ARMv7-M defconfigs
In-Reply-To: <1432161501-2323-1-git-send-email-stefan@agner.ch>
References: <1432161501-2323-1-git-send-email-stefan@agner.ch>
Message-ID: <20150521082604.GZ24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 21, 2015 at 12:38:21AM +0200, Stefan Agner wrote:
> Select ARM_SINGLE_ARMV7M in defconfigs of the converted ARMv7-M
> platforms.
I assume this relates to your series that introduces this symbol. Should
the defconfig update happen before? (Or what is the result if
CONFIG_ARM_SINGLE_ARMV7M=y is missing in the defconfig while the symbol
already exists?) Maybe this should be squashed into the commit in
question?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
