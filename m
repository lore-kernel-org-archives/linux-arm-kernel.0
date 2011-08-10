From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 10 Aug 2011 17:21:00 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <4E42A14B.9050308@freescale.com>
References: <4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
	<4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca>
	<4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca>
	<4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
	<4E42A14B.9050308@freescale.com>
Message-ID: <4E42A1DC.3070501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/2011 5:18 PM, Scott Wood wrote:
> On 08/09/2011 08:52 PM, David Gibson wrote:
>> Of course, the problem with reg-names is that it will be ignored by
>> older OSes, and so 'reg' must still be in the correct order.  In which
>> case you could argue it's more sensible to just have a static place to
>> name mapping in the Linux driver.
>
> I think the intent was just to use this for some new bindings -- not to
> change existing ones.

Yes, indeed. I've just realized it was maybe not clear in my email.

Thanks,
Benoit
