From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 12 Aug 2017 13:05:40 +0100
Subject: [PATCH 1/3] dt-bindings: iio: timer: stm32: add support for
 STM32H7
In-Reply-To: <20170810171217.gxms3ect2gpbizba@rob-hp-laptop>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
 <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
 <20170810171217.gxms3ect2gpbizba@rob-hp-laptop>
Message-ID: <20170812130541.227e0af3@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Aug 2017 12:12:17 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, Aug 03, 2017 at 11:14:12AM +0200, Fabrice Gasnier wrote:
> > STM32H7 has slightly different triggers than previous versions.
> > Introduce st,stm32h7-timer-trigger compatible to handle this new variant.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
