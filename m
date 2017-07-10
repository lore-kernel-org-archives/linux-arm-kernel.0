From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 10 Jul 2017 14:53:12 +0100
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <c883dfb1-1df3-13fa-dc22-efa86b18513a@codeaurora.org>
References: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
 <CAFpQJXU84OTEp-1BteQeSqNy3Ya2hDskZA=Th_0f47qtS9-ucw@mail.gmail.com>
 <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
 <ab7e26a8-5ab7-7c47-f19c-cb02fbd397b6@arm.com>
 <ba64069e-f3a3-de85-df47-01008d7b3513@codeaurora.org>
 <27b46938-ae23-9750-e0c7-09fa472d3297@arm.com>
 <CAFpQJXVVeAB7RgGKGX-hwo-0ZU8KHzy9ipgbXN0NHorUpk-5Kw@mail.gmail.com>
 <bee8ac5a-b19f-8112-5529-485c269f3501@arm.com>
 <CAFpQJXXPfBEP+_3rzkRo7Ydb31GKFokQB1bmOVHXSd1Pu0zsyA@mail.gmail.com>
 <ed7416f2-e60b-bf8c-cdbe-8a83e83ca529@arm.com>
 <CAFpQJXUm5tEyaBURzx9OtssBt8+ThO0dmPqtdjjGRJzY5cMv-w@mail.gmail.com>
 <c883dfb1-1df3-13fa-dc22-efa86b18513a@codeaurora.org>
Message-ID: <7ddde76b-56d8-d20f-555a-d6166f0c7e2d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/17 13:30, Shanker Donthineni wrote:
> Marc,
> 
> Do you have any other concerns taking this patch?

Plenty. All I have seen so far is a wet finger in the air and the claim
that it reduces "something" by 5%, without any actual figure.

Sorry, I'm not buying it without people putting in the effort to show me
that this is worth it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
