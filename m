From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 30 May 2017 16:20:11 +0530
Subject: [PATCH v2] ARM: dts: da850: Add interrupt-controller property to
 gpio node
In-Reply-To: <1495634501-3246-1-git-send-email-j-keerthy@ti.com>
References: <1495634501-3246-1-git-send-email-j-keerthy@ti.com>
Message-ID: <fe594161-3adf-8cd8-df41-63daca1cfeff@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 May 2017 07:31 PM, Keerthy wrote:
> The gpio node has 144 gpios. Each gpio is capable of generating
> an interrupt. Hence add interrupt-controller property to the gpio
> node. With this in place one can use interrupts property in device
> tree to request for the gpio interrupts.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Applied to v4.13/dt

Thanks,
Sekhar
