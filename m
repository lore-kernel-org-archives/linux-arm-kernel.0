From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 11 Mar 2014 10:04:21 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <CAMuHMdWqt4M5OEXp8y_DR8UEA8GPxJg99cz-HcmMPQB+h+Rh0A@mail.gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<1393604717.3802.61.camel@paszta.hi.pengutronix.de>	<CAL_JsqJ00Zr1tMoyR1+qHUhsNoc6Kj6s+nTZTkNTwki9HFHq8g@mail.gmail.com>	<531EAF8F.2040400@ti.com>
 <CAMuHMdWqt4M5OEXp8y_DR8UEA8GPxJg99cz-HcmMPQB+h+Rh0A@mail.gmail.com>
Message-ID: <531EC385.7090001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/14 10:00, Geert Uytterhoeven wrote:
> On Tue, Mar 11, 2014 at 7:39 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 10/03/14 23:45, Rob Herring wrote:
>>> I like this proposal over the others. Although, would dual link be a
>>
>> I don't like inferring the information. With the above, you can't find
>> out that the DVI connector has digital and analog support before all the
>> drivers are loaded.
>>
>>> single endpoint or 2 endpoints? How would you differentiate that?
>>
>> Hmm, well endpoints for a single port are exclusive. So it's either a
>> single port and a single endpoint, or two ports and two endpoints. I
>> think dual link has to be single port & endpoint, as the TMDS links need
>> to be driven together as a single bus.
>>
>> And dual-link is not really "two links". DVI dual-link means 1 clock
>> lane and 6 data lanes, compared to 1 clock lane and 3 data lanes for
>> single-link.
> 
> What about having a property for the number of data lanes?

That was already suggested by Philipp in this thread. I don't see
anything wrong with that, but I don't really see benefit either.
"dual-link" is a standard term for 6 data lanes for the DVI connector.
And the choices are 3 or 6 data lanes, nothing else.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/c86122b5/attachment-0001.sig>
