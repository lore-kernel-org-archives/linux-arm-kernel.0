From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jun 2015 16:22:27 +0200
Subject: [PATCH v4 1/3] net: mvneta: introduce compatible string
 "marvell,armada-xp-neta"
In-Reply-To: <1435674022-13295-2-git-send-email-simon.guinot@sequanux.org>
References: <1435674022-13295-1-git-send-email-simon.guinot@sequanux.org>
 <1435674022-13295-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150630162227.6c45c953@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Tue, 30 Jun 2015 16:20:20 +0200, Simon Guinot wrote:
> The mvneta driver supports the Ethernet IP found in the Armada 370, XP,
> 380 and 385 SoCs. Since at least one more hardware feature is available
> for the Armada XP SoCs then a way to identify them is needed.
> 
> This patch introduces a new compatible string "marvell,armada-xp-neta".
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network unit")
> Cc: <stable@vger.kernel.org> # v3.8+
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
