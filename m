From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Aug 2012 15:27:50 +0200
Subject: [PATCH 2/4] arm: plat-orion: make bridge_virt_base non-const
 to support DT use case
In-Reply-To: <1343999430-31816-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1343999430-31816-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <501BD1D6.3050908@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2012 03:10 PM, Thomas Petazzoni wrote:
> For the Armada 370 and XP SoCs where the DT is used, we need to fill
> at runtime the bridge_virt_base field on the
> orion_addr_map_cfg. Therefore, remove the 'const' qualifier on this
> field.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

[...]


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
