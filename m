From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Sep 2010 13:12:37 +0100
Subject: [PATCH 1/2] ARM: S3C64XX: Fix dev-spi build
In-Reply-To: <003201cb4f4c$5e561640$1b0242c0$%kim@samsung.com>
References: <1283941539-3892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<003201cb4f4c$5e561640$1b0242c0$%kim@samsung.com>
Message-ID: <20100908121237.GA9196@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 08, 2010 at 08:52:48PM +0900, Kukjin Kim wrote:

> Anyway, this is ok to me...and how about mach-s5pc100/dev-spi.c?

I've not looked at S5PC100 since I don't have any boards with that.

> And I think, this should be gone to upstream via Ben's tree...

Yup, though the MAINTAINERS pattern matches you both.  I'm resending due
to lack of any response from Ben.
