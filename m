From: tj@kernel.org (Tejun Heo)
Date: Wed, 18 Jan 2017 11:21:05 -0800
Subject: [PATCH] ahci: qoriq: added ls2088a platforms support
In-Reply-To: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
References: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <20170118192105.GB9171@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 02:12:01PM +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Ls2088a is new introduced arm-based soc with sata support with
> following features:
> 1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
>    specification
> 2. Contains a high-speed descriptor-based DMA controller
> 3. Supports the following:
>    a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
>       (second-generation SATA), and 6 Gb/s (third-generation SATA)
>    b. FIS-based switching
>    c. Native command queuing (NCQ) commands
>    d. Port multiplier operation
>    e. Asynchronous notification
>    f. SATA BIST mode
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
