From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 14 Mar 2014 13:05:52 +0000
Subject: [PATCH 1/2] ARM: DT: fix gic interrupt controller documentation
In-Reply-To: <20140313182554.GA15990@obsidianresearch.com>
References: <1394732405-2260-1-git-send-email-tharvey@gateworks.com>
 <1394732405-2260-2-git-send-email-tharvey@gateworks.com>
 <5321EE81.1030207@wwwdotorg.org>
 <20140313182554.GA15990@obsidianresearch.com>
Message-ID: <CACxGe6sEjW+J1ZHq-qb=7yPWLEnfWkSxZvwHUVO3L9vL5rsm1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 6:25 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Mar 13, 2014 at 11:44:33AM -0600, Stephen Warren wrote:
>> On 03/13/2014 11:40 AM, Tim Harvey wrote:
>> > When using interrupt-maps, the size of a map entry is #address-cells +
>> >  #interrupt-cells for the parent interrupt controller.  For the ARM GIC
>> > address-cells should be 0 as this is not used.
>> >
>> > This patch fixes the example by correctly specifying #address-cells = 0.
>>
>> If the #address-cells property is required (well, or even optional...)
>> in the node, shouldn't it be included in the list of required/optional
>> properties above, and not solely included in the example?
>
> AFAIK, #address-cells = 0 is the same as not including a
> #address-cells at all.
>
> Omitting entirely is what other interrupt-controller bindings are
> doing, so I'd just drop mention of #address-cells completely.

Correct. Just drop it.

g.
