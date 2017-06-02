From: tj@kernel.org (Tejun Heo)
Date: Fri, 2 Jun 2017 09:50:03 -0400
Subject: [PATCH] ahci: qoriq: add ls1088a platforms support
In-Reply-To: <1496388183-11534-1-git-send-email-andy.tang@nxp.com>
References: <1496388183-11534-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170602135003.GA18930@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 03:23:03PM +0800, Yuantian Tang wrote:
> Ls1088a is new introduced arm-based soc with sata support with
> following features:
> 
> * Complies with the serial ATA 3.0 specification
>   and the AHCI 1.3.1 specification
> * Contains a high-speed descriptor-based DMA controller
> * Supports the following:
> * Speeds of 1.5 Gb/s (first-generation SATA),
>   3 Gb/s (second-generation SATA), and 6 Gb/s (third-generation SATA)
> * FIS-based switching
> * Native command queuing (NCQ) commands
> * Port multiplier operation
> * Asynchronous notification
> * SATA Vendor BIST mode
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
