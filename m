From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 15:39:56 +0100
Subject: Help request - ASoC recursion issue
In-Reply-To: <500D5A1F.9000808@linaro.org>
References: <500D5A1F.9000808@linaro.org>
Message-ID: <20120723143955.GA8071@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 03:05:19PM +0100, Lee Jones wrote:

> I was wondering if I may bother you for some help. I've been having
> serious issues with testing the new mop500 sound system you have in

You might want to CC some of the people who wrote that code...

> The problem seems to be that 'dapm_supply_check_power()' then calls
> back into 'dapm_widget_power_check()'. Then round and round we go!

Please describe what the problem you think you're seeing is, you've just
cut'n'pasted the code into your mail without describing any actual
problem in the system...

The tree walk is recursive so the fact that we call the same function
more than once isn't terribly surprising.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/21515a9b/attachment.sig>
