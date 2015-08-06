From: tj@kernel.org (Tejun Heo)
Date: Thu, 6 Aug 2015 14:32:22 -0400
Subject: [PATCH v2] ata: ahci_brcmstb: Fix misuse of IS_ENABLED
In-Reply-To: <1438835298.28215.1.camel@ingics.com>
References: <1438835298.28215.1.camel@ingics.com>
Message-ID: <20150806183222.GA14626@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 12:28:18PM +0800, Axel Lin wrote:
> While IS_ENABLED() is perfectly fine for CONFIG_* symbols, it is not
> for other symbols such as __BIG_ENDIAN that is provided directly by
> the compiler.
> 
> Switch to use CONFIG_CPU_BIG_ENDIAN instead of __BIG_ENDIAN.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to libata/for-4.2-fixes w/ stable cc'd.

Thanks.

-- 
tejun
