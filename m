From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 14 Feb 2013 21:56:18 +0000 (UTC)
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
In-Reply-To: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1302142155520.11016@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Feb 2013, Paul Walmsley wrote:

> va = dev->bus->iounmap( ... );

And this should simply be

dev->bus->iounmap( ... );

I regret the error...

- Paul
