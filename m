From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 21 Dec 2017 11:16:39 +0900
Subject: [PATCH v3 1/6] media: rc: update sunxi-ir driver to get base
 clock frequency from devicetree
In-Reply-To: <20171219080747.4507-2-embed3d@gmail.com>
References: <20171219080747.4507-1-embed3d@gmail.com>
 <CGME20171219080753epcas5p15f4f2921a98e18db022afe8b3f2b445d@epcas5p1.samsung.com>
 <20171219080747.4507-2-embed3d@gmail.com>
Message-ID: <20171221021639.GG25647@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, Dec 19, 2017 at 09:07:42AM +0100, Philipp Rossak wrote:
> This patch updates the sunxi-ir driver to set the base clock frequency from
> devicetree.
> 
> This is necessary since there are different ir receivers on the
> market, that operate with different frequencies. So this value could be
> set if the attached ir receiver needs a different base clock frequency,
> than the default 8 MHz.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

feel free to add

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
