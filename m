From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 30 Oct 2015 13:29:39 -0500
Subject: [PATCH 02/19] Documentation: devicetree: fix reference to legacy
 wakeup properties
In-Reply-To: <563112BD.2050700@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-3-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqJ+5RNCehN9izgChf1fXhctzf+ShevjdAGnW5jF1GsAXw@mail.gmail.com>
 <563112BD.2050700@arm.com>
Message-ID: <CAL_Jsq+uooHoK19SwnhMkm6_e86FZbS0GQPZhQK9A71uWU3S5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 1:23 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 21/10/15 23:04, Rob Herring wrote:
>>
>> On Wed, Oct 21, 2015 at 5:09 AM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>>>
>>> This patch marks all the reference to the legacy wakeup bindings
>>> and replaces them with the standard "wakeup-source" property.
>>>
>>> All these legacy property are also listed under a separate section in
>>> the generic wakeup-source binding document.
>>>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>
> Thanks Rob, can you take these couple(first two) of DT binding patches
> via devicetree. I can then push remaining patches via respective trees
> later.

Both applied.

Rob
