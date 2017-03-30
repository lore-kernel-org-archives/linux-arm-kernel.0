From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 30 Mar 2017 17:22:41 +0530
Subject: [PATCH] ARM: dts: da850: move spi0_cs3_pin pinconf node
In-Reply-To: <1490663566-23062-1-git-send-email-david@lechnology.com>
References: <1490663566-23062-1-git-send-email-david@lechnology.com>
Message-ID: <7416fb5e-d949-fdb6-1ce0-2c3033d3bc76@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 March 2017 06:42 AM, David Lechner wrote:
> This moves the spi0_cs3_pin pinconf node from the LEGO EV3 file to the
> common DA850 include file. This node is applicable to any board, and
> therefore belongs in the common file.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied for v4.12

Thanks,
Sekhar
