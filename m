From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:29:53 +0200
Subject: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160816093508.28307-18-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-18-lee.jones@linaro.org>
Message-ID: <20160905102953.GF31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
> We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> be more inline with the naming conventions of the subsystem.  Where
> we used to treat each line as a channel, the PWM convention is to
> describe them as devices.
> 
> The second documentation adaption entails adding support for PWM
> capture devices.  A new clock is required as well as an IRQ line.
> We're also adding a new property similar to the one described
> above, but for capture channels.  Typically, there will be less
> capture channels than PWM-out, since all channels have the latter
> capability, but only some have capture support.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-st.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied with a reworded commit message as discussed elsewhere in this
thread. I've also applied this in front of all other patches because I
think of the DT bindings as specifications that drivers implement.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/ea2a79da/attachment.sig>
