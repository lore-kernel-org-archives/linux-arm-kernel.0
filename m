From: stigge@antcom.de (Roland Stigge)
Date: Wed, 27 Jun 2012 17:26:17 +0200
Subject: [PATCH v7] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1340800392.1799.17.camel@sauron.fi.intel.com>
References: <1339064536-20553-1-git-send-email-stigge@antcom.de>
 <1340794007.29342.50.camel@sauron.fi.intel.com> <4FEAF90B.5030809@antcom.de>
 <1340800392.1799.17.camel@sauron.fi.intel.com>
Message-ID: <4FEB2619.8020000@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 02:33 PM, Artem Bityutskiy wrote:
> On Wed, 2012-06-27 at 14:14 +0200, Roland Stigge wrote:
>> Thanks for the note! I'm sending an incremental patch. There was 
>> actually only one place in the two functions that could fail
>> (return code of lpc32xx_xfer()).
> 
> Could you please check the MCL patch as well and re-send it against
> the l2 tree?
> 
> I've squashed your change into the driver and pushed out, thanks!

Yes, thanks!

Will post an updated MLC against l2-mtd later today.

Roland
