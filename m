From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 11:23:44 -0700
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq function
 is specified
In-Reply-To: <1364503606-10597-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1364503606-10597-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364503606-10597-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130402182344.GK25867@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 09:46:44PM +0100, Maxime Ripard wrote:
> More and more sub-architectures are using only the irqchip_init
> function. Make the core code call this function if no init_irq field is
> provided in the machine description to remove some boilerplate code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to next/cleanup (fixed the typo in the subject though :).

I'm trying to figure out how to best apply 2/2 without causing a lot of
merge conflicts. It might make sense to either do it late in the merge
window or stage it at the base of 3.11 cleanup. I'll revisit after I've
dealt with the rest of the pull request queue.


-Olof
