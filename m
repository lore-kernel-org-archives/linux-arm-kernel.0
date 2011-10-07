From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 7 Oct 2011 11:00:55 -0700
Subject: [PATCH v7 0/3] Add support for tegra2 based ventana board
In-Reply-To: <1317647918-22694-1-git-send-email-pdeschrijver@nvidia.com>
References: <1317647918-22694-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173B23B2F1@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Monday, October 03, 2011 7:19 AM:
> This patch set adds support for the tegra2 based ventana development board.
> 
> Boot tested on ventana.

With minor changes to the command-line in tegra-ventana.dts, to put the
root fs on an SD card, and using mainline U-Boot with the Ventana patch
series I wrote,

Tested-by: Stephen Warren <swarren@nvidia.com>

I have a couple of queries in patch 3 that I'll post separately.

-- 
nvpublic
