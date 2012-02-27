From: stigge@antcom.de (Roland Stigge)
Date: Mon, 27 Feb 2012 23:04:02 +0100
Subject: [PATCH v3] ARM: LPC32xx: Ethernet support
In-Reply-To: <20120227180814.GB21386@pengutronix.de>
References: <1330364762-23203-1-git-send-email-stigge@antcom.de>
 <20120227180814.GB21386@pengutronix.de>
Message-ID: <4F4BFDD2.8060007@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/12 19:08, Wolfram Sang wrote:
> On Mon, Feb 27, 2012 at 06:46:02PM +0100, Roland Stigge wrote:
>> This patch adds ethernet support to the LPC32xx ARM architecture.
>> The actual driver in drivers/net is contained in a separate
>> patch.
>> 
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>> 
>> ---
> 
> Please add below this dashed line what changed since the last
> version. This makes reviewing easier.

OK, will do next time.

For the driver, some style fixes were applied, and the cmdline
"ethaddr" was removed, relying on the bootloader to set it correctly
(and it actually does, it actually needs to prepare TFTP booting).

The platform-support patch just adjusted to the small driver change:
driver name adjustment ("lpc-eth") for consistency.

Roland
