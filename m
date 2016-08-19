From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Aug 2016 09:35:57 +0100
Subject: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160818192002.GA26225@rob-hp-laptop>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-18-lee.jones@linaro.org>
 <20160818192002.GA26225@rob-hp-laptop>
Message-ID: <20160819083557.GK4254@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Aug 2016, Rob Herring wrote:

> On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > be more inline with the naming conventions of the subsystem.  Where
> > we used to treat each line as a channel, the PWM convention is to
> > describe them as devices.
> 
> This is out of date now. Otherwise, the binding looks fine.

Yes, you are right.

Perhaps if this is okay with Thierry, he can remove these few lines.
If not, I don't mind re-sending on request.

I'll leave it until I hear otherwise.

> > The second documentation adaption entails adding support for PWM
> > capture devices.  A new clock is required as well as an IRQ line.
> > We're also adding a new property similar to the one described
> > above, but for capture channels.  Typically, there will be less
> > capture channels than PWM-out, since all channels have the latter
> > capability, but only some have capture support.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-st.txt | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
