From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 5 Sep 2010 09:48:06 +0100
Subject: [PATCH] MMC: move regulator handling closer to core v2
In-Reply-To: <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
Message-ID: <20100905084806.GB24817@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 09:38:45PM +0200, Linus Walleij wrote:

> This has an Reveiwed-by from the regulator maintainer and
> seems to address all comments, noone is objection so Andrew
> can you pick it up?

Just to clarify, I'm only one of the regulator maintainers - Liam also
maintains the regulator API.
