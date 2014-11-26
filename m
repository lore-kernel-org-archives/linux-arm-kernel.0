From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 13:17:17 +0100
Subject: [PATCH 2/2] MAINTAINERS: ARM Versatile Express platform
In-Reply-To: <1417003449.3972.1.camel@arm.com>
References: <1416939455-1814-1-git-send-email-pawel.moll@arm.com>
 <1416967146.8358.19.camel@perches.com> <1417003449.3972.1.camel@arm.com>
Message-ID: <2667096.evZZoH9ryD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 12:04:09 Pawel Moll wrote:
> 
> Right, of course. Whole directory.
> 
> > F:    */*/vexpress*
> 
> Cool, didn't think about multiple wildcards. 

Actually, I think you could even do this as

N:	vexpress

which would be even shorter and match most of the other entries too.

	Arnd
