From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Jul 2014 10:36:03 +0100
Subject: [PATCH v3 1/9] arm64: KVM: rename pm_fake handler to trap_raz_wi
In-Reply-To: <20140709092712.GA19801@cbox> (Christoffer Dall's message of
 "Wed, 9 Jul 2014 10:27:12 +0100")
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
 <1403269207-1625-2-git-send-email-marc.zyngier@arm.com>
 <20140709092712.GA19801@cbox>
Message-ID: <87tx6q7u2k.fsf@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09 2014 at 10:27:12 am BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, Jun 20, 2014 at 01:59:59PM +0100, Marc Zyngier wrote:
>> pm_fake doesn't quite describe what the handler does (ignoring writes
>> and returning 0 for reads).
>> 
>> As we're about to use it (a lot) in a different context, rename it
>> with a (admitedly cryptic) name that make sense for all users.
>> 
>> Reviewed-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>
> didn't I already review this?  Did something change, it doesn't look
> like it from the changelog....
>
> /me confused.

Nothing changed, just me forgetting to add your Reviewed-by tag.

Sorry about that.

	M.
-- 
Without deviation from the norm, progress is not possible.
