From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sun, 22 Jan 2017 08:57:00 +0530
Subject: [PATCH 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig
In-Reply-To: <20170119142424.GZ27312@n2100.armlinux.org.uk>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
 <20170119142424.GZ27312@n2100.armlinux.org.uk>
Message-ID: <20170122032700.GA13580@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 19, 2017 at 02:24:24PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 19, 2017 at 02:07:39AM +0530, afzal mohammed wrote:

> > +#define VECTORS_BASE		0xffff0000
> 
> This should be UL(0xffff0000)

This has been taken care in v2.

Regards
afzal
