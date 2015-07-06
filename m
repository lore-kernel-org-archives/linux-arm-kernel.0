From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jul 2015 15:41:28 +0100
Subject: [PATCH] ARM: mm: use virt_to_idmap to get phys_reset address
In-Reply-To: <1433254470-26507-1-git-send-email-vitalya@ti.com>
References: <1433254470-26507-1-git-send-email-vitalya@ti.com>
Message-ID: <20150706144128.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:14:30AM -0400, Vitaly Andrianov wrote:
> This patch is to get correct physical address of the reset function for
> PAE systems, which use aliased physical memory for booting.
> 
> See the "ARM: mm: Introduce virt_to_idmap() with an arch hook" for details.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>

Please send this to the patch system, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
