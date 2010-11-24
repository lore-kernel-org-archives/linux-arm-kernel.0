From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Nov 2010 16:09:16 +0000
Subject: [PATCH v3] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <1290599914-13691-1-git-send-email-pawel.moll@arm.com>
References: <1290599914-13691-1-git-send-email-pawel.moll@arm.com>
Message-ID: <AANLkTikXw0GRrZkMTKC3E6wXwr_gwDh4zJXy7db6g9j0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2010 11:58, Pawel Moll <pawel.moll@arm.com> wrote:
> This change limits number of GIC-originating interrupts to the
> platform maximum (defined by NR_IRQS) while still initialising
> all distributor registers.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Looks fine to me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
