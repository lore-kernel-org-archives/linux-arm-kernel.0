From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 27 Jan 2014 10:19:37 -0500
Subject: [RFC/PATCH] ARM: dove: Remove UBI support from defconfig
In-Reply-To: <20140127151429.GB3036@localhost>
References: <1390829189-25073-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140127150040.GH29184@titan.lakedaemon.net>
 <20140127151429.GB3036@localhost>
Message-ID: <20140127151937.GI29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:14:30PM -0300, Ezequiel Garcia wrote:
> On Mon, Jan 27, 2014 at 10:00:40AM -0500, Jason Cooper wrote:
> > On Mon, Jan 27, 2014 at 10:26:29AM -0300, Ezequiel Garcia wrote:
> > > As NAND support is not enabled by default, it's hard to see
> > > why we'd want to have UBI support. Let's remove it.
> > 
> > I'd rather add support for the nand.
> > 
> 
> Well, there isn't any Dove board (that we currently support) with a NAND
> device. Would you still want to add it?

sh*t.  you're right.  My memory is failing me.  I'll queue this up.

thx,

Jason.
