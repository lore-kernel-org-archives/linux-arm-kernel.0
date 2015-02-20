From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 20 Feb 2015 08:23:47 -0500
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <23825C6A-7FF1-4D06-8802-F6964F71B97C@konsulko.com>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <54E54586.5070602@gmail.com>
 <23825C6A-7FF1-4D06-8802-F6964F71B97C@konsulko.com>
Message-ID: <54E73563.5070404@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2015 09:41 AM, Pantelis Antoniou wrote:
> Hi Frank,
> 
>> On Feb 19, 2015, at 04:08 , Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 2/18/2015 6:59 AM, Pantelis Antoniou wrote:
>>> Implement a method of applying DT quirks early in the boot sequence.
>>>
>>> A DT quirk is a subtree of the boot DT that can be applied to
>>> a target in the base DT resulting in a modification of the live
>>> tree. The format of the quirk nodes is that of a device tree overlay.
>>
>> The use of the word "quirk" is a different mental model for me than what
>> this patch series appears to be addressing.  I would suggest totally
>> removing the word "quirk" from this proposal to avoid confusing the
>> mental models of future generations of kernel folks.
>>
> 
> Naming things is hard to do. Suggestions?

variant
