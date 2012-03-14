From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Mar 2012 10:29:00 -0700
Subject: [PATCH V2 2/3] pinctrl: allow concurrent gpio and mux function
 ownership of pins
In-Reply-To: <CACRpkdYsD2LCNoox6ztHTP76X8a_qxjiZFO4ou=BgZ4oE0qHtg@mail.gmail.com>
References: <1330993336-9538-1-git-send-email-swarren@nvidia.com>
 <1330993336-9538-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYdSaNsrr34o2Cc4vS12ee9oY7FG0pxB92mefHZKwdEpA@mail.gmail.com>
 <4F5E3F63.5080506@wwwdotorg.org>
 <CACRpkdYsD2LCNoox6ztHTP76X8a_qxjiZFO4ou=BgZ4oE0qHtg@mail.gmail.com>
Message-ID: <20120314172900.GB14853@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 10:42:48PM +0100, Linus Walleij wrote:
> On Mon, Mar 12, 2012 at 7:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
> > Linus, now that Grant has ack'd and applied the documentation change
> > behind this, could you take this one patch into the pinctrl tree.
> 
> Of course, applied.
> 
> > I assume it's 3.5 material.
> 
> No it goes in now, we can't have documentation that is misleading...
> Besides, I like it.

Oops, this reply didn't show before I hit reply on the other one.

Stephen, that makes things easy for you if you still need time to sort things
out on the tegra side, since 3.4-rc1 can be the base for that work.


-Olof
