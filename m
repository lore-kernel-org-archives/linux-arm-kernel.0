From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Nov 2011 21:19:11 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1322579473-8804-4-git-send-email-pawel.moll@arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-4-git-send-email-pawel.moll@arm.com>
Message-ID: <201111292119.11554.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2011, Pawel Moll wrote:
> +                       compact-flash at 1a000 {
> +                               compatible = "ata-generic";
> +                               reg = <0x1a000 0x100
> +                                      0x1a100 0xf00>;
> +                               reg-shift = <2>;
> +                       };

Shouldn't there also be a more specific "compatible" value, in case we have
to detect this CF slot for some reason?

Is there actually no interrupt?

	Arnd
