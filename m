From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 19 Sep 2014 22:40:39 +0200
Subject: [PATCH 2/8] ARM: mvebu: armada-xp: Add node alias to pinctrl
 and add base address
In-Reply-To: <1411157684-6991-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1411157684-6991-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140919224039.0cccd4d3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Fri, 19 Sep 2014 22:14:38 +0200, Sebastian Hesselbarth wrote:
> In other MVEBU SoCs, the pin controller node is called pin-ctrl with
> its base address added. Also, we have a node alias to access the pinctrl
> node easily. Fix this for Armada XP pinctrl nodes to be consistent with
> other SoCs.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Note sure why we're using pin-ctrl rather than pinctrl, but I don't
really care, so:

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
