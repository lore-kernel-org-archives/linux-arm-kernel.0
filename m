From: brendan.jackman@arm.com (Brendan Jackman)
Date: Mon, 12 Sep 2016 16:19:43 +0100
Subject: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <20160902201605.GA1705@linaro.org>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
 <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
 <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
 <20160902201605.GA1705@linaro.org>
Message-ID: <87sht59mcw.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Lina,

Sorry for the delay here, Sudeep and I were both been on holiday last week.

On Fri, Sep 02 2016 at 21:16, Lina Iyer wrote:
> On Fri, Sep 02 2016 at 07:21 -0700, Sudeep Holla wrote:
[...]
>>This version is *not very descriptive*. Also the discussion we had on v3
>>version has not yet concluded IMO. So can I take that we agreed on what
>>was proposed there or not ?
>>
> Sorry, this example is not very descriptive. Pls. check the 8916 dtsi
> for the new changes in the following patches. Let me know if that makes
> sense.

The not-yet-concluded discussion Sudeep is referring to is at [1].

In that thread we initially proposed the idea of, instead of splitting
state phandles between cpu-idle-states and domain-idle-states, putting
CPUs in their own domains and using domain-idle-states for _all_
phandles, deprecating cpu-idle-states. I've brought this up in other
threads [2] but discussion keeps petering out, and neither this example
nor the 8916 dtsi in this patch series reflect the idea.

It would be great if we could go back to the thread at [1] where Sudeep
has posted examples and come to a clear consensus on the binding design
before reviewing implementation patches. Ideally with input from Ulf,
Rob and Kevin.

[1] https://patchwork.kernel.org/patch/9264507
[2] http://www.spinics.net/lists/devicetree/msg141024.html
>
> Thanks,
> Lina
>
>>We could have better example above *really* based on the discussions we
>>had so far. This example always makes me think it's well crafted to
>>avoid any sort of discussions. We need to consider different use-cases
>>e.g. what about CPU level states ?
>>
>>IMO, we need to discuss this DT binding in detail and arrive at someq
>>conclusion before you take all the troubles to respin the series.
>>Also it's better to keep the DT binding separate until we have some
>>conclusion instead of posting the implementation for each version.
>>That's just my opinion(I would be least bothered about implementation
>>until I know it will be accepted before I can peek into the code, others
>>may differ.
>>
>>--
>>Regards,
>>Sudeep

Cheers,
Brendan
