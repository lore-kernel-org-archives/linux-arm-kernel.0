From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 24 Nov 2011 12:09:26 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
References: <20111123122855.GB7382@totoro>
 <20111123130134.GB12227@opensource.wolfsonmicro.com>
 <20111123133237.GC7382@totoro>
 <20111123135033.GA20272@opensource.wolfsonmicro.com>
 <20111123143322.GD7382@totoro>
 <20111123145517.GE20272@opensource.wolfsonmicro.com>
 <4ECD32CA.2030601@gmail.com>
 <20111123175446.GI30049@opensource.wolfsonmicro.com>
 <alpine.LFD.2.02.1111231402370.17904@xanadu.home>
 <alpine.LFD.2.02.1111231929050.17904@xanadu.home>
Message-ID: <20111124120925.GH8470@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 07:32:58PM -0500, Nicolas Pitre wrote:

> OK, here it is.  Please try this patch:

Ah, excellent - that does get me debug output which halts at:

| Memory policy: ECC disabled, Data cache writeback.

if that rings any bells.  I'll poke around further when I get a chance.

> Then, if you didn't already do so, you should enable CONFIG_DEBUG_LL 
> and hack something like this into the printk code:

Yeah, I do.  We should probably have this in the standard code as an
option somehow, it's fairly painless but irritating.
