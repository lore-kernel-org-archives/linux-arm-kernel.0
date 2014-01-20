From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 20 Jan 2014 11:39:21 -0800
Subject: [PATCH -next] mtd: nuc900_nand: remove redundant return value
 check of platform_get_resource()
In-Reply-To: <001401cf0c04$691d63d0$3b582b70$%han@samsung.com>
References: <CAPgLHd_RMOPLP2f4nA1vqNNddocMUX7f-gE29TTkuJZPUm=SWw@mail.gmail.com>
 <001401cf0c04$691d63d0$3b582b70$%han@samsung.com>
Message-ID: <20140120193921.GR8919@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 08:58:49AM +0900, Jingoo Han wrote:
> On Tuesday, January 07, 2014 10:39 PM, Wei Yongjun wrote:
> > 
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > Remove unneeded error handling on the result of a call
> > to platform_get_resource() when the value is passed to
> > devm_ioremap_resource().
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Pushed to l2-mtd.git. Thanks!

Brian
