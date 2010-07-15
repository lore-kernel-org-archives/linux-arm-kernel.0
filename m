From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 15 Jul 2010 10:48:01 +0800
Subject: [RFC,PATCH 0/3] Allow late mdesc detection, v2
In-Reply-To: <1279073377.400469.233833413341.0.gpush@pororo>
References: <1279073377.400469.233833413341.0.gpush@pororo>
Message-ID: <1279162081.15089.77.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

> v2:
>  * return both phys and virt addresses from addruart
>  * mask unneeded bits from uart physical address in mapping setup
>  * remove io_pg_offst and phys_io, in a separate patch
> 
> ---
> Jeremy Kerr (3):
>       arm: return both physical and virtual addresses from addruart
>       arm: use addruart macro to establish debug mappings
>       arm: remove machine_desc.io_pg_offst and .phys_io


Looks like 3/3 is too large and got stuck in moderation - These patches
(plus the fixup series) are available in my git tree, in the 'debug'
branch:

git://kernel.ubuntu.com/jk/dt/linux-2.6

Specifically, patch 3 is at:

http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=commitdiff;h=41249a2461f8294fefd9186a27b8c3a4e3cd4f54

[342 files changed, 1 insertion(+), 821 deletions(-)]

Cheers,


Jeremy
