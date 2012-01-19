From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 Jan 2012 08:01:44 -0600
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core
 tile (TC1 variant)
In-Reply-To: <1326980594.32197.67.camel@hornet.cambridge.arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>
 <4F0C495C.4000103@citrix.com>
 <1326979652.32197.66.camel@hornet.cambridge.arm.com>
 <4F181BD9.20401@gmail.com>
 <1326980594.32197.67.camel@hornet.cambridge.arm.com>
Message-ID: <4F182248.7070209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2012 07:43 AM, Pawel Moll wrote:
> On Thu, 2012-01-19 at 13:34 +0000, Rob Herring wrote:
>>> You're right - the skeleton.dtsi contains "memory" mode... Funnily
>>> enough originally I was using that name, but then Rob Herring suggested
>>> changing it to @80000000, which seemed reasonable.
>>>
>>> Now I wonder - is the "memory" node special and should not contain
>>> "@address", or the skelton shouldn't contain the empty "memory" node...
>>>
>>
>> Hummm... I guess you should just use "memory" if you are using
>> skeleton.dtsi.
> 
> Well, I don't mind _not_ using skeleton, but I had an impression the
> general policy was to use it?

Either way is fine. I don't really think it buys you much.

Rob
