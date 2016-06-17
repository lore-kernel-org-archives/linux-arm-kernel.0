From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 17 Jun 2016 23:53:21 +0300
Subject: [PATCH] ARM: dts: silk: add DU pins
In-Reply-To: <2415333.mtLdVEoB2G@wasted.cogentembedded.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <2415333.mtLdVEoB2G@wasted.cogentembedded.com>
Message-ID: <f9aee8b5-7f78-acd0-e544-3d5977c01246@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/13/2016 10:36 PM, Sergei Shtylyov wrote:

> Add the (previously omitted) DU pin data to the SILK board's device tree.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'renesas-devel-20160411-v4.6-rc3' tag of Simon
> Horman's 'renesas.git' repo. It depends on the R8A7794 DU PFC driver patch
> just posted for the pins to be configured...

    Simon, this patch seems stuck while the PFC driver patch hit Linus' tree 
long ago. :-(

MBR, Sergei
