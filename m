From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 20 Feb 2014 10:30:17 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <52F51922.6030502@gmail.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
Message-ID: <1392892217.23342.18.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-07 at 18:34 +0100, Sebastian Hesselbarth wrote:
> On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> > Now that all the device tree support is in mach-mvebu, remove it from
> > mach-kirkwood.
> >
> > Regenerate kirkwood_defconfig, removing all DT support, and a couple

s/DT/board-file/?

> > of other redundent options have been removed in the process.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> 
> Hmm, I wonder what Ian thinks of removing this so quickly again...

I don't want to stand in the way of progress. What version is this
targeting so I can setup our tooling to DTRT and append a DTB under the
correct circumstances.

I still need to figure out how to distinguish the variations, but I
think I have a plan there (via which PCI buses are present, which is a
bit skanky but seems like the most workable solution).

Ian.

> Maybe let it rot for 1-2 kernel versions?
> 
> Sebastian
> 
> 
