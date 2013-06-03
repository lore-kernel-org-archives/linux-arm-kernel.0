From: w@1wt.eu (Willy Tarreau)
Date: Mon, 3 Jun 2013 23:07:21 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603191730.GR3803@titan.lakedaemon.net>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu> <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu> <20130603184148.GQ3803@titan.lakedaemon.net>
 <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
 <20130603191730.GR3803@titan.lakedaemon.net>
Message-ID: <20130603210721.GC9868@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 03:17:31PM -0400, Jason Cooper wrote:
> > Or some board specific code could dig them out of the flash.  That at 
> > least would make this hack localized while keeping the common code 
> > clean.
> 
> If it comes to that, I think I would rather tell users to put the mac
> address on the commandline.

Yes, I think that's the least annoying solution for the end user. We
could even have the driver complain and explain to the user what to
do when it has to generate a random MAC address.

Willy
