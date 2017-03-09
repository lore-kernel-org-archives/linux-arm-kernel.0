From: tj@kernel.org (Tejun Heo)
Date: Thu, 9 Mar 2017 11:56:47 -0500
Subject: [PATCH] ahci: qoriq: correct the sata ecc setting error
In-Reply-To: <1489050809-15265-1-git-send-email-andy.tang@nxp.com>
References: <1489050809-15265-1-git-send-email-andy.tang@nxp.com>
Message-ID: <20170309165647.GB28982@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 09, 2017 at 05:13:29PM +0800, Yuantian Tang wrote:
> Sata ecc is controlled by only 1 bit which is 24bit in big-endian
> in ecc register. So only setting 24bit to disable sata ecc prevents
> other bits from being overwritten in ecc register.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied to libata/for-4.11-fixes.

Thanks.

-- 
tejun
