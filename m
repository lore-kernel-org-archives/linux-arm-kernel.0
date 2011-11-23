From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 12:05:35 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111122222135.GB7845@gallagher>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
Message-ID: <20111123120534.GO21073@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 10:21:35PM +0000, Jamie Iles wrote:

> No, you're right - this is the offending commit.  It actually needs 
> this[1] fix and things should be okay.

> 1. https://lkml.org/lkml/2011/11/10/186

I've tested with that patch and it doesn't seem to be the only fix
that's required - my system still exhibits the same behaviour.
