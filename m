From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Jan 2014 09:07:32 +0100
Subject: Nomadik clk not MULTI_V5 friendly
In-Reply-To: <20140120220118.GN15169@lunn.ch>
References: <20140120220118.GN15169@lunn.ch>
Message-ID: <CACRpkdYEembRxxq-1btov17+5UKdaLYyOPdJiAcAvSX=oPYj5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 11:01 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> It does not check if it is actually running on a Nomadik, so when this
> module_init() is executed on kirkwood as part of a MULTI_V5 kernel,
> bad things happen. Please could you add the necessary check.

Sure, fixed it, can you test and provide your Tested-by tag to Mike
so he can merge it?

Yours,
Linus Walleij
