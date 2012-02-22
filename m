From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 09:50:40 +0000
Subject: [PATCH v2 06/19] ARM: at91/pm_slowclock: rename register to
 named define
In-Reply-To: <cce50d2859ae080d6bfd9260fcd6932d634f7b9a.1329903206.git.nicolas.ferre@atmel.com>
References: <0d78171672a30e8ec8084f54a557e9948260356d.1329903206.git.nicolas.ferre@atmel.com>
 <cce50d2859ae080d6bfd9260fcd6932d634f7b9a.1329903206.git.nicolas.ferre@atmel.com>
Message-ID: <20120222095040.GU22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 10:39:32AM +0100, Nicolas Ferre wrote:
>  #define PLLALOCK_TIMEOUT	1000
>  #define PLLBLOCK_TIMEOUT	1000
>  
> +#define pmc	r1

pmc	.req	r1
sdramc	.req	r2

etc.
