From: tj@kernel.org (Tejun Heo)
Date: Thu, 19 Mar 2015 14:21:09 -0400
Subject: [PATCH] ata: sata_mv: add proper definitions for LP_PHY_CTL
 register values
In-Reply-To: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150319182109.GB19657@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 02:36:37PM +0100, Thomas Petazzoni wrote:
> Commit 9013d64e661fc ("ata: sata_mv: fix disk hotplug for Armada
> 370/XP SoCs") added some manipulation of the LP_PHY_CTL register, but
> using magic values. This commit changes the code to use proper
> definitions for the LP_PHY_CTL register, which allows to document what
> the different bits are doing.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.1.

Thanks.

-- 
tejun
