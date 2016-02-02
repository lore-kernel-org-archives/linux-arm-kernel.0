From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Feb 2016 22:19:38 +0100
Subject: [PATCH] soc: rockchip: power-domain: fix err handle while probing
In-Reply-To: <1454314720-6391-1-git-send-email-shawn.lin@rock-chips.com>
References: <1454314720-6391-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <50160822.GDSasZvf15@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 1. Februar 2016, 16:18:40 schrieb Shawn Lin:
> If we fail to probe the driver, we should not directly break
> from the for_each_available_child_of_node since it calls of_node_get
> while iterating. This patch add of_node_put to fix the unbalanced
> call pair.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

applied to my drivers-branch for 4.6


Thanks
Heiko
