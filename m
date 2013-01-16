From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Jan 2013 13:35:18 -0500
Subject: [PATCH] ata: sata_mv: fix sg_tbl_pool alignment
In-Reply-To: <20130116175203.GK25500@titan.lakedaemon.net>
References: <20130115175020.GA3764@kroah.com>
 <20130115201617.GC25500@titan.lakedaemon.net>
 <20130115215602.GF25500@titan.lakedaemon.net>
 <50F5F1B7.3040201@web.de>
 <20130116024014.GH25500@titan.lakedaemon.net>
 <50F61D86.4020801@web.de> <50F66B1B.40301@web.de>
 <20130116155045.GI25500@titan.lakedaemon.net>
 <50F6DDF7.9080605@web.de>
 <20130116175203.GK25500@titan.lakedaemon.net>
Message-ID: <20130116183518.GL25500@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >On Wed, Jan 16, 2013 at 09:55:55AM +0100, Soeren Moch wrote:
> > >>I don't want to say that Mareks patch is wrong, probably it triggers a
> > >>bug somewhere else! (in em28xx?)

Could you send the output of:

lsusb -v -d VEND:PROD

for the em28xx?

thx,

Jason.
