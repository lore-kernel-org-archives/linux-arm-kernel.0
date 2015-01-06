From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 20:33:41 +0100
Subject: [PATCH 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
In-Reply-To: <94f9823d9a8c9c7ef819173f0a5ab06fb8fff408.1420499393.git.dhdang@apm.com>
References: <cover.1420499393.git.dhdang@apm.com>
 <94f9823d9a8c9c7ef819173f0a5ab06fb8fff408.1420499393.git.dhdang@apm.com>
Message-ID: <22570652.F088Afk9OX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 08:15:41 Duc Dang wrote:
> X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
> 16 HW IRQ lines.
> 
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> 

I might be a little behind the latest development, but why is this
not a struct msi_controller?

	Arnd
