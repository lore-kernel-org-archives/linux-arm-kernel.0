From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Wed, 11 Oct 2017 17:22:51 +0100
Subject: [PATCH v3 5/7] nvmem: imx-ocotp: Add i.MX7D timing write clock
 setup support
In-Reply-To: <1507737805.22082.11.camel@pengutronix.de>
References: <1507558312-20580-1-git-send-email-pure.logic@nexus-software.ie>
 <1507558312-20580-6-git-send-email-pure.logic@nexus-software.ie>
 <1507737805.22082.11.camel@pengutronix.de>
Message-ID: <308e3067-cc2c-d9a3-33e2-912a3302ceb7@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/17 17:03, Philipp Zabel wrote:
> Would
> 
> 	fsource = DIV_ROUND_UP_ULL((u64)clk_rate * DEF_FSOURCE,
> 				   NSEC_PER_SEC) + 1;
> 	strobe_prog = DIV_ROUND_CLOSEST_ULL((u64)clk_rate * DEF_STROBE_PROG,
> 					    NSEC_PER_SEC) + 1;
> 
> work instead?

Might do, I'll see and change it if it works
