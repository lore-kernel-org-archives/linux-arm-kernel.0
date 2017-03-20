From: rric@kernel.org (Robert Richter)
Date: Mon, 20 Mar 2017 11:49:46 +0100
Subject: [PATCH 1/2] PCI: Use Cavium assigned hardware ID for ThunderX
 host controller
In-Reply-To: <1489564155-3881-2-git-send-email-tn@semihalf.com>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
 <1489564155-3881-2-git-send-email-tn@semihalf.com>
Message-ID: <20170320104946.GL4906@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On 15.03.17 08:49:14, Tomasz Nowicki wrote:
> "CAV" is the only PNP/ACPI hardware ID vendor prefix assigned to Cavium
> so fix this as it should be from day one.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

there is no firmware with 'THRX0002', so tagging this as
stable. Tested with latest firmware.

Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
Cc: <stable@vger.kernel.org> # v4.10
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>

Please apply.

Thanks,

-Robert
