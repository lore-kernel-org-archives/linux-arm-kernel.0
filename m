From: joe@perches.com (Joe Perches)
Date: Wed, 15 Mar 2017 07:17:24 -0700
Subject: [PATCH 23/35] drivers/mfd: Convert remaining uses of pr_warning
 to pr_warn
In-Reply-To: <20170315122300.jwuogngm6obgvz5z@dell>
References: <cover.1487314666.git.joe@perches.com>
 <a6c827c14d0b9f4be42e549ec4c629245516e979.1487314667.git.joe@perches.com>
 <20170314140455.umlhdbuj3grqtu6i@dell>
 <1489511868.2582.2.camel@perches.com>
 <20170315122300.jwuogngm6obgvz5z@dell>
Message-ID: <1489587444.2582.6.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-15 at 12:23 +0000, Lee Jones wrote:
> On Tue, 14 Mar 2017, Joe Perches wrote:
[]
> > never break user-visible strings such as
> > printk messages, because that breaks the ability to grep for them.
> 
> Right, I'm aware of this.  I'm also aware of the other rule we have
> where lines are not to exceed 80 chars.  Hence my question; "is the 80
> chars rule the lessor sin of the two".
> 
> Rock <=> hard place
> 
> Actually I would say that the error message sub-optimal and could, in
> fact be edited to be more succinct, thus not breaking any rules. 

It's not a 'sin' at all.

The rule is to exceed 80 columns when the logging
message format is long.

I didn't even look at the format content.
Change it if you wish.
