From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 9 Jul 2014 02:27:12 -0700
Subject: [PATCH v3 1/9] arm64: KVM: rename pm_fake handler to trap_raz_wi
In-Reply-To: <1403269207-1625-2-git-send-email-marc.zyngier@arm.com>
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
 <1403269207-1625-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140709092712.GA19801@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 01:59:59PM +0100, Marc Zyngier wrote:
> pm_fake doesn't quite describe what the handler does (ignoring writes
> and returning 0 for reads).
> 
> As we're about to use it (a lot) in a different context, rename it
> with a (admitedly cryptic) name that make sense for all users.
> 
> Reviewed-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

didn't I already review this?  Did something change, it doesn't look
like it from the changelog....

/me confused.
