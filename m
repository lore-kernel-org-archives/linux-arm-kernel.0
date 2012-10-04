From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Oct 2012 17:27:23 +0530
Subject: [PATCH v3 3/6] ARM: davinci: da850: changed SRAM allocator to
 shared ram.
In-Reply-To: <1349276133-26408-4-git-send-email-mporter@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <1349276133-26408-4-git-send-email-mporter@ti.com>
Message-ID: <506D79A3.4020506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On 10/3/2012 8:25 PM, Matt Porter wrote:
> From: Subhasish Ghosh <subhasish@mistralsolutions.com>
> 
> This patch modifies the sram allocator to allocate memory
> from the DA8XX shared RAM.
> 
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> [rebased onto consolidated SRAM patches]
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> [rebased to mainline as consolidated SRAM patches were dropped]
> Signed-off-by: Matt Porter <mporter@ti.com>

Were you able to test PM with this change or you need my help?

Thanks,
Sekhar
