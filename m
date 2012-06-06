From: stigge@antcom.de (Roland Stigge)
Date: Wed, 06 Jun 2012 11:01:44 +0200
Subject: [PATCH v5] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338972168.6875.7.camel@sauron.fi.intel.com>
References: <1338837901-24075-1-git-send-email-stigge@antcom.de>
 <1338972168.6875.7.camel@sauron.fi.intel.com>
Message-ID: <4FCF1C78.5000309@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2012 10:42 AM, Artem Bityutskiy wrote:
> On Mon, 2012-06-04 at 21:25 +0200, Roland Stigge wrote:
>> +config MTD_NAND_SLC_LPC32XX +	bool "NXP LPC32xx SLC Controller"
> 
> Why bool and not tristate here? Why you force this to be
> compiled-in and make it impossible to be a kernel module like other
> drivers are?

Right - the solution for both issues you mention (compiling as module
and linker error) is replacing above "bool" with "tristate".

Will post an updated patch.

Thanks,

Roland
