From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 15 Aug 2013 23:30:24 +0400
Subject: [PATCH v4 4/5] ARM: davinci: da850: add DT node for eth0.
In-Reply-To: <1376546497-26931-5-git-send-email-prabhakar.csengg@gmail.com>
References: <1376546497-26931-1-git-send-email-prabhakar.csengg@gmail.com>
 <1376546497-26931-5-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <520D2C50.4040902@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-08-2013 10:01, Lad, Prabhakar wrote:

> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

> Add eth0 device tree node information and pinmux for mii to da850 by
> providing interrupt details and local mac address of eth0.

> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
[...]

> @@ -226,6 +242,20 @@
>   			#size-cells = <0>;
>   			reg = <0x224000 0x1000>;
>   		};
> +		eth0: emac at 1e20000 {

    According to the ePAPR spec[1] section 2.2.2, the node should be named 
"ethernet".

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei
