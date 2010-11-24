From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Nov 2010 10:48:51 +0000
Subject: [PATCH 2/3] regulators: Update of ab8500 driver
In-Reply-To: <4CECC555.8060408@stericsson.com>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1290536754-21775-3-git-send-email-bengt.g.jonsson@stericsson.com>
	<20101123183833.GB19212@rakim.wolfsonmicro.main>
	<4CECC555.8060408@stericsson.com>
Message-ID: <20101124104851.GA24970@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 08:57:09AM +0100, Bengt Jonsson wrote:

> Removing the macros is just my suggestion. The disadvantage I see
> with macros is that I need to read both the macro and the listing to
> see what it really does. On the other hand, macros are probably more

A line of comment at the top of the macro table would probably address
that?
