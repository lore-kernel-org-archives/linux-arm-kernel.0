From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Mar 2015 14:00:24 -0500
Subject: [PATCH v4] dt-bindings: brcm: rationalize Broadcom documentation
 naming
In-Reply-To: <55125894.2070303@broadcom.com>
References: <1426899982-19733-1-git-send-email-sbranden@broadcom.com>
 <550F6A5B.8050906@gmail.com> <55125894.2070303@broadcom.com>
Message-ID: <CAL_JsqLGz59fyC6h7XEh=UHOCzgTUY0Y2TSrZTHmv4U8nBpunw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 1:41 AM, Scott Branden <sbranden@broadcom.com> wrote:
> Hi Rob,
>
> On 15-03-22 06:20 PM, Rob Herring wrote:
>>
>> On 03/20/2015 08:06 PM, Scott Branden wrote:
>>>
>>> This patchset attempts to standardize the naming of dt-bindings
>>> documents based on the Broadcom vendor prefix of brcm.
>>>
>>> Although there are no guidelines currently present for how to name
>>> the dt-bindings document the "vendor,binding.txt" style is in use by
>>> some of the other vendors.
>>>
>>> Acked-by: Lee Jones <lee@kernel.org>
>>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
>>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>>> Signed-off-by: Scott Branden <sbranden@broadcom.com>
>>
>>
>> Version history would be nice...
>
> Yes, I should have added a cover letter but didn't.  The difference between
> versions was minimal: a spelling correction in the commit message text and a
> few additional binding files were found that were added between the
> versions, along with the Ack's.
>
>>
>> Who did you want to apply this? I can, but I'm worried about merge
>> conflicts here. Hopefully, you're not also doing lots of changes to
>> existing bindings.
>
>
> Yes, it would be great for you to take care of applying this.  There
> shouldn't be any merge conflicts as none of these bindings are currently
> being updated.  I left a clock binding document out of this patchset at Ray
> Jui is updating/renaming the documentation for that binding in a different
> patch already.

Okay, thanks. I've applied it.

Rob
