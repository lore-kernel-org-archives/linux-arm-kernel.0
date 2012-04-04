From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 4 Apr 2012 14:24:38 +0200
Subject: [PATCH 1/5] ARM: remove ixp23xx and ixp2000 platforms
In-Reply-To: <4F7C3C2B.2050208@gmail.com>
References: <1333503243-7702-1-git-send-email-robherring2@gmail.com>
 <4F7C3C2B.2050208@gmail.com>
Message-ID: <20120404122438.GZ28523@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 07:18:51AM -0500, Rob Herring wrote:

> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > ixp2xxx platforms have had no real changes since ~2006 and the maintainer
> > has said on irc that they can be removed:
> > 
> > 13:05 < nico> do you still care about ixp2000?
> > 13:22 < lennert> not really, no
> > 13:58 < nico> do you think we could remove it from the kernel tree?
> > 14:01 < lennert> go for it, and remove ixp23xx too while you're at it

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>


> > Removing will help simplify ARM consolidation in general and PCI re-work
> > specifically.

But this seems pretty specious.
