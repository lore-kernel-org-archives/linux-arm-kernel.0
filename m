From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jan 2016 16:56:57 +0000
Subject: next boot: 564 boots: 59 failed, 448 passed with 57 offline
 (next-20160107)
In-Reply-To: <20160107162810.GA25177@ulmo>
References: <568e8740.01941c0a.31072.ffffb67b@mx.google.com>
 <20160107155958.GG6588@sirena.org.uk> <20160107162810.GA25177@ulmo>
Message-ID: <20160107165657.GH6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 05:28:10PM +0100, Thierry Reding wrote:

> These should all be fixed by this patch:

> 	serial: 8250: of: Fix the driver and actually compile the 8250_of

> which can be found in patchwork here:

> 	https://patchwork.kernel.org/patch/7883541/

> I think this is merely waiting to be picked up into the tty tree. I

Ah, good - hopefully that'll get picked up quickly, I suspect it's going
to turn out to be responsible for a bunch of the other failures we're
seeing at the minute.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160107/2d36c905/attachment-0001.sig>
