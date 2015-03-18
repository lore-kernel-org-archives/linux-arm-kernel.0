From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Mar 2015 17:12:17 +0100
Subject: [PATCH] ARM: mvebu: Conform L2CC node with ePAPR specification
 by adding cache-level
In-Reply-To: <1426610034-4204-1-git-send-email-gregory.clement@free-electrons.com>
References: <1426610034-4204-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150318171217.101ae9b0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 17 Mar 2015 17:33:54 +0100, Gregory CLEMENT wrote:
> For L2 cache controller node, cache-level property is mandatory. Let's
> add it to Armada 370 and Armada XP device tree.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
