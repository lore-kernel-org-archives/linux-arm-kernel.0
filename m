From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Feb 2015 09:57:25 +0000
Subject: [PATCH v5 0/7] irqchip: Move OMAP{4,
 5}/DRA7 to use stacked domains
In-Reply-To: <CAJydem=O0S0dKL6pOvm79bNYinDcFVhQE0qUW43Qhvfo7voqtA@mail.gmail.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
 <20150223230205.GJ32521@atomide.com> <20150224001145.GK32521@atomide.com>
 <CAJydem=O0S0dKL6pOvm79bNYinDcFVhQE0qUW43Qhvfo7voqtA@mail.gmail.com>
Message-ID: <54EC4B05.6020000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/15 03:45, Subramaniam Chanderashekarapuram wrote:
> 
> Tested this on  DRA7 for smp_affinity. Needs these minor fixes attached.
> 
> Note: I do not have a OMAP4/5 with me now. Hope to test that tomorrow.
> 
> Log for DRA7 are here:
> http://pastebin.ubuntu.com/10382176/

Looks good to me. I've folded that into the existing series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
