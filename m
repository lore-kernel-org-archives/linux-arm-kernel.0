From: zbr@ioremap.net (Evgeniy Polyakov)
Date: Mon, 23 Jan 2012 23:36:38 +0300
Subject: [PATCH] W1: OMAP HDQ1W: use 32-bit register accesses
In-Reply-To: <alpine.DEB.2.00.1201231155590.29673@utopia.booyaka.com>
References: <alpine.DEB.2.00.1201221319270.26641@utopia.booyaka.com>
 <20120123150753.GA21395@ioremap.net>
 <alpine.DEB.2.00.1201231155590.29673@utopia.booyaka.com>
Message-ID: <20120123203638.GA8313@ioremap.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 11:57:09AM -0700, Paul Walmsley (paul at pwsan.com) wrote:
> http://www.spinics.net/lists/arm-kernel/msg156572.html

Well, if runtime PM does its job for clock manipulation properly, then
things should be fine. I suppose that ->probe() will fire up first and
you say it boots and detects w1 properly, so patch looks good.
Feel free to add my ack

-- 
	Evgeniy Polyakov
