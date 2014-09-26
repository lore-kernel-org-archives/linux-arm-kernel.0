From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 26 Sep 2014 12:30:40 -0700
Subject: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <20140926191253.GH390@ilina-mac.local> (Lina Iyer's message of
 "Fri, 26 Sep 2014 13:12:53 -0600")
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
 <1F7E5951-7704-4ADE-A1D1-2E380FF2540A@codeaurora.org>
 <20140924184750.GA1004@ilina-mac.local>
 <7hwq8q2og3.fsf@deeprootsystems.com>
 <20140926191253.GH390@ilina-mac.local>
Message-ID: <7hr3yy2n8f.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Fri, Sep 26 2014 at 13:04 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> On Wed, Sep 24 2014 at 12:07 -0600, Kumar Gala wrote:

[...]

>>>>
>>>>General comment, lets use qcom instead of msm for various things.
>>>>
>>>>[snip]
>>>>
>>> OK, Done. I renamed all msm_ functions to qcom_ functions as well.
>>>
>>
>>Does that apply to the other parts of this series too?  like the msm-pm
>>and cpuidle layers?
>>
> Yes, there are no more msm's anymore :)
>

<can of worms>

What about Documentation/devicetree/bindings/arm/msm?

</can of worms>
