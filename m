From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 May 2011 06:01:39 +0100
Subject: [PATCH 0/4] Samsung: Move Samsung SoCs GPIO drivers to
	drivers/gpio
In-Reply-To: <20110527032243.GJ5032@ponder.secretlab.ca>
References: <20110520054441.GA9952@july>
	<20110520063128.GA21285@ponder.secretlab.ca>
	<20110521112102.GA11887@sirena.org.uk>
	<20110527032243.GJ5032@ponder.secretlab.ca>
Message-ID: <20110527050138.GA23418@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 09:22:43PM -0600, Grant Likely wrote:

> True, this does come down to personal taste, but unless someone has a
> really strong objection to it then I'll keep asking for new drivers to
> use gpio- as a prefix.

Right, my thought was more that if that's going to be the way forward
it's probably worth renaming the existing drivers so people don't get
confused - people are likely to pick the visible convention as their
first thought so we should either standardise on the existing one or
change what's there.  It's nicer if what you're supposed to do is what
everyone's actually doing :)
