From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Apr 2015 11:01:20 +0100
Subject: Programming the boundary between Inner and Outer caches on ARM
 architecture
In-Reply-To: <CAJWVF-w5YpZjRqnvbz1p70_WTBROL9vDkvYb_sG43nGp=s1vLg@mail.gmail.com>
References: <CAJWVF-w5YpZjRqnvbz1p70_WTBROL9vDkvYb_sG43nGp=s1vLg@mail.gmail.com>
Message-ID: <20150420100119.GC24715@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 09:45:08PM +0530, Bhaskara rao Budiredla wrote:
> Hi - can someone please provide the register details to configure the
> boundary between Inner and Outer caches? In a three level cache
> system, it is desired to apply Inner cacheable attributes to level 1
> cache and Outer cacheable attributes to level two & level three
> caches.

Who told you that?

-- 
Catalin
