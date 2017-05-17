From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 May 2017 14:53:06 +0530
Subject: [PATCH 1/2] ARM: davinci: PM: Free resources in error handling
 path in 'davinci_pm_init'
In-Reply-To: <20170513114005.23617-1-christophe.jaillet@wanadoo.fr>
References: <20170513114005.23617-1-christophe.jaillet@wanadoo.fr>
Message-ID: <bec1f848-a556-3912-56b1-c239ce62ae8d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 May 2017 05:10 PM, Christophe JAILLET wrote:
> If 'sram_alloc' fails, we need to free already allocated resources.
> 
> Fixes: aa9aa1ec2df6 ("ARM: davinci: PM: rework init, remove platform device")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to fixes for v4.12.

Thanks,
Sekhar
