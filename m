From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Nov 2010 13:41:13 +0000
Subject: [PATCH] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <1290431295-16052-1-git-send-email-pawel.moll@arm.com>
References: <1290431040-15417-1-git-send-email-pawel.moll@arm.com>
	<1290431295-16052-1-git-send-email-pawel.moll@arm.com>
Message-ID: <AANLkTikEDb-JCe7zVvF7pt+p=wwP15M5ApTD77dNddZj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2010 13:08, Pawel Moll <pawel.moll@arm.com> wrote:
> This change limits number of GIC-originating interrupts to the
> platform maximum (defined by NR_IRQS) while still initialising
> all distributor registers.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

This looks better to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
