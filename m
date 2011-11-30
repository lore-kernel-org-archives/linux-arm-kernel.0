From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2011 15:10:44 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <1322660291.10583.2.camel@hornet.cambridge.arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <201111301334.40372.arnd@arndb.de>
 <1322660291.10583.2.camel@hornet.cambridge.arm.com>
Message-ID: <201111301510.44363.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 November 2011, Pawel Moll wrote:
> Ok, as the actual "interface hardware" is a custom design for VE, I'll
> make it:
> 
>         compatible = "arm,vexpress-cf", "ata-generic";
> 
> Does it make sense?
> 

Yes, very good.

	Arnd
