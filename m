From: rob@landley.net (Rob Landley)
Date: Mon, 17 Jun 2013 00:20:35 -0500
Subject: [PATCH] pinctrl: update GPIO range doc
In-Reply-To: <1371377909-5921-1-git-send-email-linus.walleij@stericsson.com>
 (from linus.walleij@stericsson.com on Sun Jun 16 05:18:29 2013)
References: <1371377909-5921-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1371446435.2776.122@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2013 05:18:29 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This updates the GPIO range documentation with the API changes
> for sparse/random/arbitrary pin-to-GPIO mappings.

Acked-by: Rob Landley <rob@landley.net>

Why isn't this part of the pinctrl series you posted right afterwards?  
(It should go in through that maintainer...)

>  For all functionalities dealing with pin biasing, pin muxing etc,  
> the pin
> -controller subsystem will subtract the range's .base offset from the  
> passed
> -in gpio number, and add the ranges's .pin_base offset to retrive a  
> pin number.
> -After that, the subsystem passes it on to the pin control driver, so  
> the driver
> +controller subsystem will look up the corresponding pin number from  
> the passed
> +in gpio number, and use the ranges internals to retrive a pin  
> number. After

Range's perhaps?

Rob
