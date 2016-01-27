From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Jan 2016 15:10:26 +0100
Subject: [PATCH v2 1/2] ARM: tegra: Fixed typo
In-Reply-To: <56A88AC6.4090105@nvidia.com>
References: <1453827558-10954-1-git-send-email-ralf@ramses-pyramidenbau.de>
 <1453827558-10954-2-git-send-email-ralf@ramses-pyramidenbau.de>
 <CAAVeFuKiaSZH5RF=zEnYVoRU_rtVvONRYdtGbK=fgV_icO8tDw@mail.gmail.com>
 <56A883C7.9000007@ramses-pyramidenbau.de>
 <56A88AC6.4090105@nvidia.com>
Message-ID: <20160127141026.GA21779@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 06:15:50PM +0900, Alexandre Courbot wrote:
> On 01/27/16 17:45, Ralf Ramsauer wrote:
> >On 01/27/2016 08:59 AM, Alexandre Courbot wrote:
> >>Hey Ralf, thanks for following up with patches as we discussed in private!
> >>
> >>Small nit: you will want to use the active form ("Fix typo" instead of
> >>"Fixed typo") in your commit messages.
> >So even my language skills got improved ;-)
> 
> This is grammatically correct, but using imperative form is the convention
> in the kernel. As per Documentation/SubmittingPatches:
> 
> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.
> 
> >>It would also be nice if the commit title was a little more precise
> >>about where the typo has been corrected.
> >Uhm - as this is be pretty small non-diff-related change... Is it
> >necessary to send a v3 or would it also be okay to let the maintainer
> >amend the subject?
> >(to sth.: like "ARM: tegra: Fix the same C&P typo in several dts includes")
> 
> Let's see what Thierry says about this.

I've changed this when applying and also added a full commit message.
Doing so might arguably be a little overkill, but in doing so I realized
that the same typo was there in the Tegra132 and Tegra210 DTS includes,
so I fixed those up in a separate patch while at it. I made it a
separate patch because the arm-soc maintainers want arch/arm and
arch/arm64 changes to come in via separate branches. I did add a
Suggested-by for Ralf since he spotted the original typo, I hope that's
okay with everyone.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/24bc8ead/attachment-0001.sig>
