From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 10:44:31 +0100
Subject: KVM: CONFIG_LOCK_DEP and CONFIG_LOCK_DETECTOR?
In-Reply-To: <54C14D01.2010506@arm.com>
References: <1421919245.13638.50.camel@x220> <54C14BCF.1050902@samsung.com>
 <54C14D01.2010506@arm.com>
Message-ID: <20150123094431.GI15076@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 07:18:25PM +0000, Marc Zyngier wrote:
> On 22/01/15 19:13, Mario Smarduch wrote:
> > On 01/22/2015 01:34 AM, Paul Bolle wrote:
> >> Mario,
> >>
> >> Your commit c64735554c0a ("KVM: arm: Add initial dirty page locking
> >> support") is included in today's linux-next (ie, next-20150122). I
> >> noticed because a script I use to check linux-next spotted a minor
> >> problem with it.
> >>
> >> This commit added a comment that mentions CONFIG_LOCK_DEP and
> >> CONFIG_LOCK_DETECTOR. It seems CONFIG_LOCKDEP and CONFIG_LOCKUP_DETECTOR
> >> should be used instead. Is a trivial patch to fix these typos queued
> >> somewhere?
> >>
> >> Thanks,
> >>
> >>
> >> Paul Bolle
> >>
> > 
> > Hi Paul,
> >   thanks for spotting that. No there is no trivial patch
> > queued, didn't notice it until now. Can I submit a follow
> > up trivial patch later?
> 
> Yeah, that can definitely wait. I think we have slightly bigger fish to
> fry for now... ;-)
> 
> If someone sends us a patch once -rc1 is out, we'll queue it.
> 
I'll just fix it up before sending the pull request today.

-Christoffer
