From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 26 Oct 2012 14:08:47 +0530
Subject: [PATCH RFT] ARM64: dma-mapping: support debug_dma_mapping_error
In-Reply-To: <1351205220.6851.3.camel@lorien2>
References: <1351205220.6851.3.camel@lorien2>
Message-ID: <508A4C17.7010607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 October 2012 04:17 AM, Shuah Khan wrote:
> Add support for debug_dma_mapping_error() call to avoid warning from
> debug_dma_unmap() interface when it checks for mapping error checked
> status. Without this patch, device driver failed to check map error
> warning is generated.
>
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> ---
Looks good. Similar fix for 32bit ARM port is done in below commit.

 From 871ae57adc5ed092c1341f411514d0e8482e2611 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@canonical.com>
Date: Mon, 22 Oct 2012 20:44:03 +0800
Subject: [PATCH] ARM: dma-mapping: support debug_dma_mapping_error


Regards
Santosh
