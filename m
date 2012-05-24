From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 24 May 2012 08:46:35 -0700
Subject: [PATCH V2] GPMI-NAND: Define ecc.strength
In-Reply-To: <201205220834.25981.marex@denx.de>
References: <1337633967-8387-1-git-send-email-marex@denx.de>
 <1337668383.2483.87.camel@sauron.fi.intel.com>
 <201205220834.25981.marex@denx.de>
Message-ID: <4FBE57DB.400@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2012 11:34 PM, Marek Vasut wrote:
> Dear Artem Bityutskiy,
> 
>> On Mon, 2012-05-21 at 22:59 +0200, Marek Vasut wrote:
>>> The ecc.strength wasn't set, resulting in the following crash:
>>> [    2.550000] kernel BUG at drivers/mtd/nand/nand_base.c:3347!
>>> [    2.550000] Internal error: Oops - BUG: 0 [#1] ARM
>>
>> Pushed to l2-mtd.git, thanks!
> 
> Thank you!


Yes, thanks much Marek.  I must have missed this one while doing the EUCLEAN
patches (maybe because it's in its own directory).  Sorry to everyone for the
confusion it caused.

Mike
