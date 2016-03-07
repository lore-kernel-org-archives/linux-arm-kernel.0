From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Mar 2016 09:39:26 +0000 (UTC)
Subject: [PATCH 0/2] ARM: dra7: Enable Errata i877
In-Reply-To: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <alpine.DEB.2.02.1603070938170.3437@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Mar 2016, Lokesh Vutla wrote:

> This series enables Errata i877 for all DRA7 platforms. The public errata
> documentation can be found here[1].
> 
> [1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
> 
> Lokesh Vutla (1):
>   ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
> 
> Mugunthan V N (1):
>   ARM: dts: dra7: do not gate cpsw clock due to errata i877

I've sent these for merging immediately. 

Have you sent patches for U-boot yet?


- Paul
