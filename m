From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 12 Dec 2016 13:31:50 +0300
Subject: [PATCH renesas/devel 12/13] ARM: dts: r8a7793: Use R-Car Gen 2
 fallback binding for i2c nodes
In-Reply-To: <1481533902-14789-13-git-send-email-horms+renesas@verge.net.au>
References: <1481533902-14789-1-git-send-email-horms+renesas@verge.net.au>
 <1481533902-14789-13-git-send-email-horms+renesas@verge.net.au>
Message-ID: <d6bf2bcf-937b-fcf2-8b07-98249d9f75bf@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2016 12:11 PM, Simon Horman wrote:

> Use recently added R-Car Gen 2 fallback binding for iii nodes in

    s/iii/iic/?

> DT for r8a7793 SoC.
>
> This has no run-time effect for the current driver as the initialisation
> sequence is the same for the SoC-specific binding for r8a7793 and the
> fallback binding for R-Car Gen 2.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
