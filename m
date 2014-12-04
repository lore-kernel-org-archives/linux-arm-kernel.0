From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 17:10:52 +0100
Subject: [PATCH 2/2] arm64: amd-seattle: Fix PCI bus range due to SMMU
 limitation
In-Reply-To: <1417405600-19232-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1417405600-19232-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1417405600-19232-3-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <2035567.rcXVTvDFpt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 30 November 2014 21:46:40 suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> Since PCIe is using SMMUv1 which only supports 15-bit stream ID,
> only 7-bit PCI bus id is used to specify stream ID. Therefore,
> we only limit the PCI bus range to 0x7f.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 

Applied the second patch, thanks!

	Arnd
