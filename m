From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 22 Dec 2014 12:47:37 +0100
Subject: [PATCH v4 5/5] media: ov2640: dt: add the device tree binding
 document
In-Reply-To: <5497F327.4040903@atmel.com>
References: <1418869646-17071-1-git-send-email-josh.wu@atmel.com>
 <1418869646-17071-6-git-send-email-josh.wu@atmel.com>
 <5492C4E3.4050401@samsung.com> <5497F327.4040903@atmel.com>
Message-ID: <549804D9.4010504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On 22/12/14 11:32, Josh Wu wrote:
>>> +Required Properties:
>>> >> +- compatible: Must be "ovti,ov2640"
>> > I believe it is preferred to put it as "Should contain", rather than
>> > "Must be".
>
> I don't have a strong opinion here. After check many documents, it seems 
> many people use "Should be".
> Is it okay?

That's probably slightly better. In general, the point is that the
'compatible' property could potentially contain multiple values, e.g. when
there is introduced a common more generic compatible value for a set
of sensors. However your documentation now says that only one specific value
is allowed. I'm adding Mark at Cc, perhaps he can explain it better.

Please don't consider it as an objection from my side, since we now have
mixture of "must be", "should be", "should contain", etc. across the
DT binding documentation files.

--
Regards,
Sylwester
