From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 14 Jan 2014 09:41:48 -0500
Subject: [PATCH] spi: davinci: fix build warning when printing
 resource_size_t vars
In-Reply-To: <20140114143945.GP15567@sirena.org.uk>
References: <20140112110916.GR15937@n2100.arm.linux.org.uk>
 <1389707408-24785-1-git-send-email-grygorii.strashko@ti.com>
 <20140114143945.GP15567@sirena.org.uk>
Message-ID: <52D54CAC.1050005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 January 2014 09:39 AM, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 03:50:08PM +0200, Grygorii Strashko wrote:
>> Use %pa format specifier when printing variables of resource_size_t type
>> to fix build warnings:
>> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'resource_size_t'
>> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t'
> 
> This doesn't apply against current code, it seems the same patch has
> already been applied.
> 
Yeah. I did send same patch last merge window time-frame which has been
applied by you.

Regards,
Santosh
