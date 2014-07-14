From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 13:00:51 +0100
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
Message-ID: <20140714120051.GF6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 01:50:55PM +0200, Stefan Assmann wrote:
> This partly reverts the following commits to get the wifi working on
> the Pandaboard OMAP4430 ES2.2.

> 0e8e5c34cf1a8beaaf0a6a05c053592693bf8cb4 regulator: twl: Remove references to 32kHz clock from DT bindings
> d1924519fe1dada0cfd9a228bf2ff1ea15840c84 regulator: twl: Remove TWL6030_FIXED_RESOURCE
> 029dd3cefa46ecdd879f9b4e2df3bdf4371cc22c regulator: twl: Remove another unused variable warning
> e76ab829cc2d8b6350a3f01fffb208df4d7d8c1b regulator: twl: Remove references to the twl4030 regulator

No, you need to implement clocks using the clock API.  Please read the
changelogs for the above commits...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/9c610af0/attachment.sig>
