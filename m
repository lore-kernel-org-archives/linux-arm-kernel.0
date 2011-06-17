From: khilman@ti.com (Kevin Hilman)
Date: Fri, 17 Jun 2011 13:59:28 -0700
Subject: [PATCH] ARM: OMAP: Overo: remove duplicate call to
	overo_ads7846_init()
In-Reply-To: <1308327432-31177-1-git-send-email-zonque@gmail.com> (Daniel
	Mack's message of "Fri, 17 Jun 2011 18:17:12 +0200")
References: <87r56sbg3b.fsf@ti.com>
	<1308327432-31177-1-git-send-email-zonque@gmail.com>
Message-ID: <87lix0b2dr.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> overo_ads7846_init() is already called from overo_spi_init(), and
> calling it twice is not only unnecessary but causes a warning as
> "reg-fixed-voltage.1" is already added to the device tree.

Excellent, thanks!

> Signed-off-by: Daniel Mack <zonque@gmail.com>

Tested-by: Kevin Hilman <khilman@ti.com>
