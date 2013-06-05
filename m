From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 05 Jun 2013 20:25:25 +0900
Subject: [PATCH 1/2] ARM: dts: add DP clock reference to exynos5250 device
 tree
In-Reply-To: <CAGm_ybh_Uvs2dX3Ecgcwy=GFO6QH-Hj1jz3f1=cDbZGq0Q4qDQ@mail.gmail.com>
References: <003001ce4e1b$24a28fc0$6de7af40$@samsung.com>
 <CAGm_ybh_Uvs2dX3Ecgcwy=GFO6QH-Hj1jz3f1=cDbZGq0Q4qDQ@mail.gmail.com>
Message-ID: <08da01ce61df$6013ba70$203b2f50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas Sajjan wrote:
> 
> Hi Mr. Jingoo Han,
> 
> On Sat, May 11, 2013 at 1:12 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> The transition to common clock happened; however, DP (Display Port)
> clock node was not added. Thus, DP (Display Port) clock node should
> be added to the device tree.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Tested on Exynos5250
> 
> ?arch/arm/boot/dts/exynos5250.dtsi | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)

[...]

> ?I have already sent similar patch on 8th May 2013.
> 
> http://www.spinics.net/lists/linux-samsung-soc/msg18136.html

Vikas, please don't use html typed e-mail :-(

OK, I found Jingoo's ack on that.

Let me take that with Jingoo's ack and Doug's review tag.

Thanks.

- Kukjin
