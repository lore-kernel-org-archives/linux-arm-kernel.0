From: stigge@antcom.de (Roland Stigge)
Date: Wed, 07 Mar 2012 12:53:28 +0100
Subject: [PATCH v5] lpc32xx: Added ethernet driver
In-Reply-To: <201203062134.38077.arnd@arndb.de>
References: <1331067664-9124-1-git-send-email-stigge@antcom.de>
 <201203062134.38077.arnd@arndb.de>
Message-ID: <4F574C38.4030006@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03/06/2012 10:34 PM, Arnd Bergmann wrote:
> This should eventually both become run-time options based on the device tree.
> I don't know if you planned to do that anyway, but if you want the same kernel
> binary to be used for systems in different configurations, you cannot have
> compile-time decisions that are exclusive-or. Since you don't support device
> tree yet but plan to do that in the future, you could add a comment here
> about it, or you could even prepare it for that case already by passing the
> device into the functions that will be required for reading the properties.

Good point.

I prefer putting a comment for now, because upon the planned device tree
introduction in lpc32xx, an internal change in lpc_eth.c will be
necessary anyway, so there is no need to already introduce unused
parameters at this point.

Thanks,

Roland
