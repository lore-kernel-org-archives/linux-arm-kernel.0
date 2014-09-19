From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 19 Sep 2014 22:39:42 +0200
Subject: [PATCH 1/8] ARM: mvebu: armada-xp: Consolidate pinctrl node
In-Reply-To: <1411157684-6991-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1411157684-6991-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140919223942.38909c16@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Fri, 19 Sep 2014 22:14:37 +0200, Sebastian Hesselbarth wrote:
> All current Armada XP SoCs have their pin controller at 0x18000/0x38.
> Move the common properties of pinctrl nodes to armada-xp.dtsi to allow
> to share pinctrl settings later.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
