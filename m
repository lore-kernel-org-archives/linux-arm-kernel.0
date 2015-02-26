From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 26 Feb 2015 20:20:43 +0000
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <CAJAp7OgOjsLe2c66k8ocSCpg_JtHCJbofcxjbgBoG6fd8iFPxg@mail.gmail.com>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>	<1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAJAp7OgOjsLe2c66k8ocSCpg_JtHCJbofcxjbgBoG6fd8iFPxg@mail.gmail.com>
Message-ID: <54EF801B.4080201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/02/15 19:00, Bjorn Andersson wrote:
> On Sun, Feb 22, 2015 at 11:54 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> This patch adds rpm node to apq8064 dt as rpm would be used by other
>> devices for regulator support. Also adds all the regulators in the rpm.
>>
>
> This looks good, with Kumars suggestion of GIT defines
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
Thanks Bjorn for Review.

> However, this binding is not merged yet and Stephen have requesting a
> complete redesign of the binding as well as the code. So that has to
> be concluded first, I presume.
>
Hmm, I know, It does not make sense to keep these patches locally 
waiting for something to change in future, Am not sure when those new 
changes be actually merged into the mainline?

IMHO, we should merge this patches as they are perfectly applicable to 
whats on linus-tree. And fix if required when the new design is accepted.

>
> Separate of that, as it's highly likely that everyone will follow the
> pcb design guidelines for apq8064 the vin-supplies should be okay to
> specify at this level (and not in all board files). Perhaps also the
> switching frequencies for the SMPSs?

I will investigate on this and see If I can add some more useful 
contents to the nodes.

Thanks,
srini
>
> Regards,
> Bjorn
>
