From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Apr 2018 14:25:46 +0300
Subject: [PATCH v2] arm64: dts: renesas: eagle: add EtherAVB pins
In-Reply-To: <382aeecb-c484-ec27-1ef1-8da1673c2c14@cogentembedded.com>
References: <382aeecb-c484-ec27-1ef1-8da1673c2c14@cogentembedded.com>
Message-ID: <8495a934-62f1-3b2e-3125-78844aef04e1@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/14/2018 10:58 PM, Sergei Shtylyov wrote:

> Add the (previously omitted) EtherAVB pin data to the Eagle board's
> device tree.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'renesas-devel-20180314-v4.16-rc5' tag of Simon's
> 'renesas.git repo. It depends on the R8A77970 PFC driver patch adding EtherAVB
> pin groups (posted yesterday) in order to work properly...

   The dependency has been now met, please merge this patch.

MBR, Sergei
