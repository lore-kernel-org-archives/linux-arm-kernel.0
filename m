From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Apr 2017 17:50:32 +0200
Subject: [PATCH 1/1] ARM: dts: armada-xp-linksys-mamba: use wan instead
 of internet for DSA port
In-Reply-To: <20170405172224.38c1f9fb@gmail.com>
References: <20170405052847.326-1-ralph.sennhauser@gmail.com>
 <20170405142824.GB13449@lunn.ch>
 <20170405172224.38c1f9fb@gmail.com>
Message-ID: <20170405155032.GL13449@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In fact "internet" label on the case is uppercase, would this matter
> for you for new bindings, or would you still use the lowercase version?

I would use lower case, just to fix with the general convention that
interface names are lower case.

> > I would say, this is now too late. Changing an interface name will
> > break configuration scripts. We are stuck with it.
> > 
> 
> If it weren't for commit cb4f71c42988 that would have been obvious for
> me as well.

Yes, that was not nice. But it was also very earlier in the life of
38x, so it just affected a few developers with reference boards, not
real products out in the wild, as far as i remember.

     Andrew
