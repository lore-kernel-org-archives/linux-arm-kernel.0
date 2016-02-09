From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 15:57:08 +0100
Subject: [PATCH V2 03/12] dtb: amd: Fix DMA ranges in device tree
In-Reply-To: <1454954357-8395-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1454954357-8395-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <2845776.WTPtnQzg8d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 11:59:08 Suravee Suthikulpanit wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Fix DMA ranges of smb0 and pcie0 nodes in AMD Seattle SOC.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 

This could use a changelog text to explain why it's broken and how the
fix works.

	Arnd
