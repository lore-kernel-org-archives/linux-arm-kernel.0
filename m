From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 15:08:03 +0100
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821135240.GJ10347@arwen.pp.htv.fi>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
 <20120821132741.GI10347@arwen.pp.htv.fi>
 <20120821134936.GH7995@opensource.wolfsonmicro.com>
 <20120821135240.GJ10347@arwen.pp.htv.fi>
Message-ID: <20120821140803.GK7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 04:52:41PM +0300, Felipe Balbi wrote:

> Fair enough, we have "quiet", but I'm not sure that's enough argument to
> allow any simple driver to start poluting dmesg with whatever random
> messages.

I think if the driver is just logging to say "I'm running" that's noise
and I do push back on that routinely myself; if the driver is providing
information it's discovered from the running system then that seems much
more useful and we should have a sensible way of getting that out in a
place where users are likely to find.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/3d6bb9bc/attachment-0001.sig>
