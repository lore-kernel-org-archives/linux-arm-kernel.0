From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Apr 2017 04:09:04 -0700
Subject: [PATCH v5 03/22] KVM: arm/arm64: vgic-its: rename itte into ite
In-Reply-To: <82b7eb70-1705-8fc5-7ec1-12ba58418389@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-4-git-send-email-eric.auger@redhat.com>
 <20170427090504.GC50776@lvm>
 <c32b8369-711c-1a1a-b3c1-bba2408ff003@arm.com>
 <82b7eb70-1705-8fc5-7ec1-12ba58418389@redhat.com>
Message-ID: <20170427110904.GI50776@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 11:40:16AM +0200, Auger Eric wrote:
> Hi Christoffer, Andre,
> 
> On 27/04/2017 11:20, Andre Przywara wrote:
> > Hi,
> > 
> > On 27/04/17 10:05, Christoffer Dall wrote:
> >> On Fri, Apr 14, 2017 at 12:15:15PM +0200, Eric Auger wrote:
> >>> The actual abbreviation for the interrupt translation table entry
> >>> is ITE. Let's rename all itte instances by ite.
> >>
> >> Is there really any confusion or problems with using itte?  This is a
> >> lot of churn...
> > 
> > I tend to agree (just didn't dare to mention this before).
> > I see that the spec speaks of "ITE", but the spelled out term hints more
> > at ITTE (because it's a "translation table").
> > Besides three letters tend to be more ambiguous than a four letter
> > identifier.
> > 
> > Would adding a comment to the structure definition help?
> > 
> > But speaking of churn I am not sure how much more work dropping this
> > patch now creates on Eric's side ...
> 
> I addressed one comment from Marc saying that ITTE was a wrong name and
> he had a patch ready to rename them.
> 
> see https://patchwork.kernel.org/patch/9513491/
> 
> Renaming back would largely impact the other patches I am afraid
> 
Ok, it's fine, Marc likes the change, and Andre is happy that you are
now responsible for all ITS bugs, and I'm happy if you're all happy.

Let's keep this change :)

-Christoffer
