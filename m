From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Jan 2017 10:04:27 +0100
Subject: [PATCH v8 3/8] PWM: add pwm-stm32 DT bindings
In-Reply-To: <1484749251-14445-4-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <1484749251-14445-4-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170119090427.GA28834@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 03:20:46PM +0100, Benjamin Gaignard wrote:
> Define bindings for pwm-stm32
> 
> version 8:
> - reword st,breakinput description.
> 
> version 6:
> - change st,breakinput parameter format to make it usuable on stm32f7 too.
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

One last nit: please use "dt-bindings: pwm:" as prefix for the patch
subject. So it would read something like this:

	dt-bindings: pwm: Add STM32 bindings

or similar. That's the style that's been used for a while now. I'd have
fixed that up myself, but since Lee plans to take this through the MFD
tree I'd like to see that fixed up before it gets applied.

With the above:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/8a632a2f/attachment.sig>
