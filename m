From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 16:34:05 +0100
Subject: [PATCH 2/5] net: mvmdio: rename base register cookie from
 smireg to regs
In-Reply-To: <1359473048-26551-3-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-3-git-send-email-florian@openwrt.org>
Message-ID: <20130129163405.15415166@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Tue, 29 Jan 2013 16:24:05 +0100, Florian Fainelli wrote:
> This patch renames the base register cookie in the mvmdio drive from
> "smireg" to "regs" since a subsequent patch is going to use an ioremap()
> cookie whose size is larger than a single register of 4 bytes. No
> functionnal code change introduced.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
