From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 13 Oct 2017 14:59:30 +0200
Subject: [PATCH v2 3/4] ACPI/IORT: Add SMMUv3 specific special index
 mapping handling
In-Reply-To: <20171013130445.GA27895@red-moon>
References: <1507878590-51066-1-git-send-email-guohanjun@huawei.com>
 <1507878590-51066-4-git-send-email-guohanjun@huawei.com>
 <20171013130445.GA27895@red-moon>
Message-ID: <1751061.R5V0ggIEsy@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 13, 2017 3:04:45 PM CEST Lorenzo Pieralisi wrote:
> [+Robert, Will]
> 
> Rafael, Robert,
> 
> On Fri, Oct 13, 2017 at 03:09:49PM +0800, Hanjun Guo wrote:
> 
> [...]
> 
> > +#if (ACPI_CA_VERSION > 0x20170929)
> 
> Any objection to handling 4.15 trees dependency by using ACPICA
> version as a temporary guard (that I will promptly remove at -rc1) ?

Well, fine by me, as long as you take care of dropping this going forward.

Thanks,
Rafael
