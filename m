From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 24 Jun 2017 21:48:13 +0100
Subject: [PATCH v2 2/3] dt-bindings: iio: update STM32 timers clock names
In-Reply-To: <20170622212539.l3yblwqurahdvlqq@rob-hp-laptop>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
 <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
 <20170622212539.l3yblwqurahdvlqq@rob-hp-laptop>
Message-ID: <20170624214813.6414e40e@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jun 2017 16:25:39 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jun 14, 2017 at 05:13:15PM +0200, Fabrice Gasnier wrote:
> > Clock name has been updated during driver/DT binding review:
> > https://lkml.org/lkml/2016/12/13/718
> > Update DT binding doc to reflect this.
> > 
> > Fixes: bf2d8581b1b3 (iio: Add bindings for STM32 timer trigger driver)
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git.  Might well have missed
the coming merge window, but guess no major hurry for this.

Jonathan
