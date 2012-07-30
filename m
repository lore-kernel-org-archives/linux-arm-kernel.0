From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 16:26:18 +0100
Subject: AB8500 Regulators
In-Reply-To: <501690F7.2010904@linaro.org>
References: <501690F7.2010904@linaro.org>
Message-ID: <20120730152618.GI4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:49:43PM +0100, Lee Jones wrote:

> I wrote a patch which pulled each of these initial values into
> Device Tree, but you NACK:ed it believing that most of the options
> could be dealt with using the API. There is currently no API to set
> up ST-Ericsson's configuration. So what's the best thing to do? How
> do all of the other regulator drivers deal with non-standard
> configuration? Or is it unheard of to use non-standard start-up
> values?

Well, a good start would be to work out what those register writes
actually do and then we can have a discussion on how to do whatever
that is.
