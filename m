From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jul 2011 10:29:00 -0700
Subject: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias ON entered
In-Reply-To: <4E118BF6.6010205@atmel.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
	<20110701161506.GC23784@opensource.wolfsonmicro.com>
	<4E118BF6.6010205@atmel.com>
Message-ID: <20110704172856.GF28726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 11:46:30AM +0200, Nicolas Ferre wrote:

> Ah, ok... but I fear that I do not know the whole system enough for this
> addition ;-(
> Do you think you can code this modification, I will be happy to test it,
> if you want...

It's pretty trivial - try the below (Liam, are you OK with this if it
tests OK?):
