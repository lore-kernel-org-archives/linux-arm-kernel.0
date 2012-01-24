From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 24 Jan 2012 01:00:49 -0700 (MST)
Subject: [PATCH] W1: OMAP HDQ1W: use 32-bit register accesses
In-Reply-To: <20120123203638.GA8313@ioremap.net>
References: <alpine.DEB.2.00.1201221319270.26641@utopia.booyaka.com>
 <20120123150753.GA21395@ioremap.net>
 <alpine.DEB.2.00.1201231155590.29673@utopia.booyaka.com>
 <20120123203638.GA8313@ioremap.net>
Message-ID: <alpine.DEB.2.00.1201240100420.29673@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jan 2012, Evgeniy Polyakov wrote:

> On Mon, Jan 23, 2012 at 11:57:09AM -0700, Paul Walmsley (paul at pwsan.com) wrote:
> > http://www.spinics.net/lists/arm-kernel/msg156572.html
> 
> Well, if runtime PM does its job for clock manipulation properly, then
> things should be fine. I suppose that ->probe() will fire up first and
> you say it boots and detects w1 properly, so patch looks good.
> Feel free to add my ack

Thanks Evgeniy.

- Paul
