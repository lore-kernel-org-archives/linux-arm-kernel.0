From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 12 Sep 2016 20:52:40 +0300
Subject: [PATCH] ARM: dts: wheat: add DU support
In-Reply-To: <15676050.WJW1jK1n2R@wasted.cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
 <15676050.WJW1jK1n2R@wasted.cogentembedded.com>
Message-ID: <ba5b2f8e-13f8-6c7d-17c1-44988d30a947@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2016 12:29 AM, Sergei Shtylyov wrote:

> Define  the  Wheat board dependent  part of the DU device node.
> Add the device nodes for the Analog Devices ADV7513 HDMI transmitters
> connected to DU0/1.  Add the necessary subnodes to interconnect DU with
> HDMI transmitters/connectors.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'renesas-devel-20160901-v4.8-rc4' of Simon Horman's
> 'renesas.git' repo plus the Wheat CAN and SDHI patches posted earlier...
> The path depends on the 2 DRM patches just posted in order to work correctly!

    In principle, both these patches have been queued by the maintainers... 
Simon, are you going to wait till they hit media_tree.git? Linus' tree?

MBR, Sergei
