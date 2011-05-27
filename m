From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 27 May 2011 02:25:33 -0600
Subject: [PATCH 2/2] GPIO: OMAP: move to drivers/gpio
In-Reply-To: <20110527073529.GF31953@ponder.secretlab.ca>
References: <1305898868-9188-1-git-send-email-khilman@ti.com>
	<1305898868-9188-3-git-send-email-khilman@ti.com>
	<20110527073529.GF31953@ponder.secretlab.ca>
Message-ID: <BANLkTinqEM-iDhgSMAnMB5uehkt=V1Qq+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 1:35 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, May 20, 2011 at 03:41:08PM +0200, Kevin Hilman wrote:
>> Move OMAP GPIO driver to drivers/gpio. ?Builds whenever
>> CONFIG_ARCH_OMAP=y.
>>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Patch unfortunately doesn't apply cleanly to Linus' tree. ?There's
> been some changes to gpio.c compared to the tree this patch was
> prepared against.
>
> Also, if you use the -M flag when preparing the patch, then I'll be
> able to see what the changes are during the move, and fix things up
> intelligently if anything breaks.
>
> Can you respin and repost the series quickly?

While you're at it, can you name the moved file
drivers/gpio/gpio-omap.c?  ('-' instead of '_'.  Why, yes, I am a
nitpicker.)

g.
