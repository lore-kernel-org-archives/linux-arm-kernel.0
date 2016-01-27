From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 27 Jan 2016 18:15:50 +0900
Subject: [PATCH v2 1/2] ARM: tegra: Fixed typo
In-Reply-To: <56A883C7.9000007@ramses-pyramidenbau.de>
References: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <1453827558-10954-2-git-send-email-ralf@ramses-pyramidenbau.de>
 <CAAVeFuKiaSZH5RF=zEnYVoRU_rtVvONRYdtGbK=fgV_icO8tDw@mail.gmail.com>
 <56A883C7.9000007@ramses-pyramidenbau.de>
Message-ID: <56A88AC6.4090105@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/16 17:45, Ralf Ramsauer wrote:
> On 01/27/2016 08:59 AM, Alexandre Courbot wrote:
>> Hey Ralf, thanks for following up with patches as we discussed in private!
>>
>> Small nit: you will want to use the active form ("Fix typo" instead of
>> "Fixed typo") in your commit messages.
> So even my language skills got improved ;-)

This is grammatically correct, but using imperative form is the 
convention in the kernel. As per Documentation/SubmittingPatches:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

>> It would also be nice if the commit title was a little more precise
>> about where the typo has been corrected.
> Uhm - as this is be pretty small non-diff-related change... Is it
> necessary to send a v3 or would it also be okay to let the maintainer
> amend the subject?
> (to sth.: like "ARM: tegra: Fix the same C&P typo in several dts includes")

Let's see what Thierry says about this.
