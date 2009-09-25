From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 25 Sep 2009 07:52:37 -0500
Subject: Adjust cache settings of user pages?
In-Reply-To: <4AB8F820.4000103@billgatliff.com>
References: <4AB8F820.4000103@billgatliff.com>
Message-ID: <4ABCBD15.1070707@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill Gatliff wrote:
> Guys:
>
>
>
> What the right API is (if there is one) to tell the kernel to turn off
> caching for a user page--- or even if such a thing is possible.  Can
> anyone offer any hints?
>   

Nevermind.

In hindsight, what I'm really doing is a kind of DMA, right?  That means 
I have to use those APIs and not just the plain old get_user_pages().  
Problem resolved.

Move along, nothing more to  see here.  :)


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
