From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 5 May 2010 22:15:14 +0200
Subject: [PATCH] fec.c: Fix memory corruption in fec_set_mac_address.
In-Reply-To: <4BDDE158.1050404@vmlinux.org>
References: <4BDDE158.1050404@vmlinux.org>
Message-ID: <20100505201514.GA25037@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mattias,

On Sun, May 02, 2010 at 10:32:24PM +0200, Mattias Walstrom wrote:
> Fix memory corruption that may result in kernel panics.
> 
> Signed-off-by: Mattias Walstr?m <mattias@vmlinux.org>
> 
You might want to send this to netdev and make sure to keep the diffstat
out of the changelog.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
