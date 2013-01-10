From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 10 Jan 2013 13:57:37 -0500
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <20130110184832.GB28004@obsidianresearch.com>
References: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20121211062430.GD25466@lunn.ch>
 <20121211065813.GA14843@obsidianresearch.com>
 <20121211071333.GR17242@lunn.ch>
 <20121211185535.GA14534@obsidianresearch.com>
 <20130110014734.GC5075@titan.lakedaemon.net>
 <20130110060710.GM24650@lunn.ch> <50EE8FC5.50105@gmail.com>
 <20130110184832.GB28004@obsidianresearch.com>
Message-ID: <20130110185737.GO5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Thu, Jan 10, 2013 at 11:48:32AM -0700, Jason Gunthorpe wrote:
> There is a bunch of prep stuff that may still be pending:
>  - Fixup remaining drivers (usb? ethernet?) to have DT bindings and
>    get the IRQ number through DT

any chance I could get you post your changes to the ethernet driver (DT
bindings)?  iirc, you said you had based them off of Ian Molton's work.
Even if you posted them RFC, it'd be a good place to start from,
reignite conversation and so forth.

thx,

Jason.
