From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Nov 2011 16:02:23 +0000
Subject: [PATCH v2 0/4] Versatile Express DT support
In-Reply-To: <4ED3AB2B.7090003@gmail.com>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <4ED399C8.9080908@gmail.com>
 <1322493617.3164.56.camel@hornet.cambridge.arm.com>
 <4ED3AB2B.7090003@gmail.com>
Message-ID: <1322496143.3164.64.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-28 at 15:39 +0000, Rob Herring wrote:
> Okay. I'll apply.
> 
> But that's just a vendor. There's still binding docs needed for the
> actual sil9022 device and some others.

I think the sil one is the only undocumented device we use now, except
for the primecells that Dave and I will take care of?

I will also cover the sii9022, if only I get clearance from our legals
(the datasheet we got is under NDA) to write a driver for it (the device
is quite complex, so I wouldn't like to define bindings without testing
them first).

Cheers!

Pawe?
