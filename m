From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Aug 2012 15:28:10 +0200
Subject: [PATCH 3/4] arm: mvebu: add basic address decoding support to
 Armada 370/XP
In-Reply-To: <1343999430-31816-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1343999430-31816-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <501BD1EA.4060300@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 03:10 PM, Thomas Petazzoni wrote:
> his commit adds basic support for address decoding configuration for
> the Armada 370 and Armada XP SoCs, re-using the infrastructure
> provided in plat-orion.
> 
> For now, only a BootROM window is configured on Armada XP, which is
> needed to get the non-boot CPUs started and is therefore a requirement
> for SMP support.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
