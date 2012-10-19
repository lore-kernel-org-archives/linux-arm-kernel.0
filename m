From: proski@gnu.org (Pavel Roskin)
Date: Fri, 19 Oct 2012 11:55:17 -0400
Subject: [ath9k-devel] [PATCH net-next 00/21] treewide: Use consistent
 api style for address testing
In-Reply-To: <1350630254.2293.183.camel@edumazet-glaptop>
References: <cover.1350618006.git.joe@perches.com>
 <1350630254.2293.183.camel@edumazet-glaptop>
Message-ID: <20121019115517.7b8514a8@mj>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Oct 2012 09:04:14 +0200
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Yes they are some names discrepancies, thats a big deal.
> 
> And we have alloc_skb() / kfree_skb() / skb_clone() 
> 
> Why not skb_alloc() / skb_free() / skb_clone() ?
> 
> Some people actually know current code by name of functions, they dont
> want to change their mind and having to grep include files and git log
> to learn the new names of an old function, especially when traveling
> and using a laptop.

I agree.

Also, it makes sense to introduce a more consistent name for a function
when it's improved in some way and the callers need to be adjusted or
re-checked.

That way, the old name can be phased out as the code is made compatible
with the new function.

-- 
Regards,
Pavel Roskin
