From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 02 Oct 2018 10:40:56 +0300
Subject: [PATCH v6 3/4] arm64: dts: dwc3: description of incr burst type
In-Reply-To: <CADRPPNQQE1ESJ5WkMxySstxpaQir-w5XOdiwDe3qTTQ_cim5Xw@mail.gmail.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-3-git-send-email-pengbo.mu@nxp.com>
 <20180724232018.GA16709@rob-hp-laptop>
 <CADRPPNQQE1ESJ5WkMxySstxpaQir-w5XOdiwDe3qTTQ_cim5Xw@mail.gmail.com>
Message-ID: <877ej0aj93.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

linux-usb-owner at vger.kernel.org writes:

> On Tue, Jul 24, 2018 at 6:23 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Mon, Jul 23, 2018 at 06:32:38PM +0800, Pengbo Mu wrote:
>> > Add description of 'snps,incr-burst-type-adjustment' to binding
>> > so that configuring devicetree.
>> >
>> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
>> > Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
>> > ---
>> >  Documentation/devicetree/bindings/usb/dwc3.txt | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> Hi Felipe,
>
> What do you think about this patch?  The patch title prefix should be
> updated from "arm64: dts: dwc3" to "dt-bindings: usb: dwc3" though.

Can you resend the series so I can apply?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181002/9afa255b/attachment.sig>
