From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 22:02:15 +0800
Subject: [PATCH v2 8/9] ASoC: imx: add dt support for audmux-v2
In-Reply-To: <20120202121020.GD7428@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
 <20120202121020.GD7428@opensource.wolfsonmicro.com>
Message-ID: <20120202140212.GC3015@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 12:10:20PM +0000, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 10:12:07AM +0800, Richard Zhao wrote:
> 
> > +Required properties:
> > +- compatible : "fsl,imx31-audmux".
> > +
> > +Example:
> > +
> > +audmux at 021d8000 {
> > +	compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
> > +	reg = <0x021d8000 0x4000>;
> 
> It's kind of obvious what it is but you should really document the reg
> property for completeness.
Right.

Thanks
Richard
