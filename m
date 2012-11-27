From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Nov 2012 10:01:43 +0000
Subject: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert to dt support
In-Reply-To: <201211270844.29311.arnd@arndb.de>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <201211262123.42812.arnd@arndb.de> <50B42B4B.90407@atmel.com>
 <201211270844.29311.arnd@arndb.de>
Message-ID: <20121127100143.GA6028@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 08:44:29AM +0000, Arnd Bergmann wrote:

> I think I'm missing context here. What's holding this up? It looks like it should
> have been merged before 531f67e41d, possibly into both arm-soc and asoc.

Jean-Christophe was very insistent that the pinctrl stuff got added and
I'd expect he'd be applying the code as he's maintaining that branch (it
doesn't apply in ASoC due to other dependencies) but I've not seen any
response from him since the code was posted.
