From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 10:41:52 +0100
Subject: [PATCH v2 2/4] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <1314080152-30503-3-git-send-email-Baohua.Song@csr.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-3-git-send-email-Baohua.Song@csr.com>
Message-ID: <20110823094152.GD19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 11:15:50PM -0700, Barry Song wrote:
> From: Rongjun Ying <rongjun.ying@csr.com>
> 
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2:
>  delete redundant ARM mode registers save/restore
>  use generic cpu suspend
>  move l2 cache suspend/resume codes out
>  make memc become a device driver

This looks much better, thanks.
