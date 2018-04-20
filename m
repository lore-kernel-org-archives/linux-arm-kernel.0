From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Apr 2018 14:28:51 +0300
Subject: [PATCH] arm64: dts: renesas: v3msk: add EtherAVB pins
In-Reply-To: <c42c9e9a-8fe8-5cad-0eeb-0c1fbd09f83c@cogentembedded.com>
References: <c42c9e9a-8fe8-5cad-0eeb-0c1fbd09f83c@cogentembedded.com>
Message-ID: <ed7ddd72-4e52-0b2b-d2ef-1d407f638745@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2018 11:30 PM, Sergei Shtylyov wrote:

> Add the (previously omitted) EtherAVB pin data to the V3M Starter Kit
> board's device tree.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'renesas-devel-20180314-v4.16-rc5' tag of Simon's
> 'renesas.git repo. It depends on the R8A77970 PFC driver patch adding EtherAVB
> pin groups (posted yesterday) in order to work properly...

   The dependency has been now met, please merge this patch.

MBR, Sergei
