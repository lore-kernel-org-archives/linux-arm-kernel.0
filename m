From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 10 Oct 2011 09:49:30 -0700
Subject: [PATCH v2 00/14] Sparse fixes for tegra
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173B23B51B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Sunday, October 09, 2011 11:28 PM:
> Some trivial fixes removing sparse warnings on tegra code.
> 
> Changes since v1:
> 
> * Implemented Arnd's suggestion to push annotation all the way down to IO_*_VIRT defines
> * Based on above, no longer needed IO_TO_VIRT() -> IO_ADDRESS() changes
> * Added two more fixes for cpu-tegra.
> 
> Stephen; I didn't explicitly apply your Acked-by lines to this batch yet,
> I will do so when I collect final acks before pushing a branch.

Just for the record; my ack still applies to the updated series.

-- 
nvpublic
