From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 19 Nov 2017 16:48:03 +0000
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: stm32: add support for
 diff channels
In-Reply-To: <20171027143729.7oqcps43qvieko4r@rob-hp-laptop>
References: <1508923665-2274-1-git-send-email-fabrice.gasnier@st.com>
 <1508923665-2274-2-git-send-email-fabrice.gasnier@st.com>
 <20171027143729.7oqcps43qvieko4r@rob-hp-laptop>
Message-ID: <20171119164803.22cd7f7f@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Oct 2017 09:37:29 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Oct 25, 2017 at 11:27:43AM +0200, Fabrice Gasnier wrote:
> > STM32H7 ADC channels may be configured either as single-ended or
> > differential.
> > Add 'st,adc-diff-channels' property to support differential channels.
> > Differential channels are defined as a pair of positive and negative
> > inputs: vinp & vinn.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v2:
> > - Add differential channels example
> > - Add a note on mixed single-ended / differential channels
> > ---
> >  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 24 ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
Thanks.  Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
