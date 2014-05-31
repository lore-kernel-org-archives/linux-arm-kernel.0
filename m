From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 May 2014 20:41:04 +0200
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
 <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <4756033.LkcFQN0chs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 May 2014 01:36:40 Liviu Dudau wrote:
> We would like to be able to describe PCIe ECAM resources as
> IORESOURCE_MEM blocks while distinguish them from standard
> memory resources. Add an IORESOURCE_BIT entry for this case.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

I still don't see any value in this at all. What is the advantage
of doing this opposed to just having a standardized 'reg' property
for a particular compatible string?

	Arnd
