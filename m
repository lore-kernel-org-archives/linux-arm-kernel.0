From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 24 Oct 2016 17:26:34 -0500
Subject: [PATCH 2/2 v5] ARM: dts: add SMSC ethernet on the APQ8060
 Dragonboard
In-Reply-To: <1477347740-10432-1-git-send-email-linus.walleij@linaro.org>
References: <1477347740-10432-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161024222634.GL3145@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 12:22:20AM +0200, Linus Walleij wrote:
> The SMSC9112 ethernet controller is connected to chip select 2
> on the EBI2 bus on the APQ8060 Dragonboard. We set this up by
> activating EBI2, creating a chipselect entry as a subnode, and then
> putting the ethernet controller in a subnode of the chipselect.
> 
> After the chipselect is configured, the SMSC device will be
> instantiated.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.  Picked this one up.


Andy
