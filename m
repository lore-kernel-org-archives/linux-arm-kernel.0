From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 17 Apr 2013 17:44:55 -0700 (PDT)
Subject: [PATCH 0/2] Add I2C support to R8A7778/BOCK-W
In-Reply-To: <201304172242.27671.sergei.shtylyov@cogentembedded.com>
References: <201304172242.27671.sergei.shtylyov@cogentembedded.com>
Message-ID: <87sj2osm4b.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

>    Here's the set of 2 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130417' tag and my recent yet unapplied patches. Here we
> add I2C support to the R8A7778 platform code and enable I2C driver on BOCK-W
> board. This will be important in the future for the VIN driver since the video
> sensor chip is controller via I2C bus #0 on BOCK-W. 
> 
> [1/2] ARM: shmobile: r8a7778: add I2C support
> [2/2] ARM: shmobile: BOCK-W: enable I2C in defconfig

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
