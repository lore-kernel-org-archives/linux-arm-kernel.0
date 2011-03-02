From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Mar 2011 11:15:47 +0000
Subject: [PATCH] ARM: SAMSUNG: Include devs.h in dev-uart.c to
	prototype devices
In-Reply-To: <1299060244-22710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299060244-22710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110302111546.GA21424@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 10:04:04AM +0000, Mark Brown wrote:
> Ensures that the declaration agrees with the definition and makes sparse
> happy.

Sorry, this patch is clearly bogus - no idea what's going on there.
