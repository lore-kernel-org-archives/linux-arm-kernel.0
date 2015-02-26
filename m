From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 26 Feb 2015 10:30:00 +0100
Subject: [PATCH v4 11/20] power_supply: Change ownership from driver to
 core
In-Reply-To: <20150226004522.GB885@earth>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
 <20150226004522.GB885@earth>
Message-ID: <1424943000.27971.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2015-02-26 at 01:45 +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Feb 23, 2015 at 12:47:32PM +0100, Krzysztof Kozlowski wrote:
> > Change the ownership of power_supply structure from each driver
> > implementing the class to the power supply core.
> > 

(...)

> 
> I would like to merge this via the power supply subsystem. Some of
> the files being patched are not under my maintainence, though. It
> would be nice if I get an Acked-By from their maintainers.
> 
> As far as I can see this patch is currently missing feedback from:
> 
> arch/x86/platform/olpc: x86 Maintainers
> drivers/acpi: Rafael J. Wysocki, Len Brown
> drivers/hid: Jiri Kosina
> drivers/platform/x86: Darren Hart

I'll respin with v5 because new power supply driver appeared in your
tree (DA9150 Charger). However this does not affect other subsystems.

Best regards,
Krzysztof
