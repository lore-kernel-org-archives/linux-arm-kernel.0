From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 12 Dec 2016 13:28:30 +0300
Subject: [PATCH renesas/devel 10/13] ARM: dts: r8a7790: Use R-Car Gen 2
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-11-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
 <1481533902-14789-11-git-send-email-horms+renesas@verge.net.au>
Message-ID: <0db5b88e-41fb-03db-fa61-48e754356901@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 12/12/2016 12:11 PM, Simon Horman wrote:

> Use recently added R-Car Gen 2 fallback binding for iii nodes in

    s/iii/iic/?

> DT for r8a7790 SoC.
>
> This has no run-time effect for the current driver as the initialisation
> sequence is the same for the SoC-specific binding for r8a7790 and the
> fallback binding for R-Car Gen 2.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
