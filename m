From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 29 Jun 2016 19:46:33 +0300
Subject: [PATCH] ARM: dts: r8a7792: add SMP support
In-Reply-To: <1627631.X1bJtVQHBF@wasted.cogentembedded.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <1627631.X1bJtVQHBF@wasted.cogentembedded.com>
Message-ID: <7c23396f-f880-40ac-654d-cffc82df021e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/21/2016 01:31 AM, Sergei Shtylyov wrote:

> Add the device tree nodes for the Advanced Power Management Unit (APMU)
> and the second Cortex-A15 CPU core.
> Use the "enable-method" prop  to point out that the APMU should be used
> for the SMP support.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'renesas-devel-20160620-v4.7-rc4' tag of Simon
> Horman's 'renesas.git' repo.  It depends on Magnus'/Geert's SMP patchset...

    simon, now that this patchset has been merged (for 4.8?), could you also 
merge this patch?

MBR, Sergei
