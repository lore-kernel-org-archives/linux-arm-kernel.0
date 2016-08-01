From: rogerq@ti.com (Roger Quadros)
Date: Mon, 1 Aug 2016 12:22:42 +0300
Subject: [PATCH 2/2] mtd: nand: omap2: Add check for old elm binding
In-Reply-To: <20160713171303.GA136972@google.com>
References: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
 <1467711150-23356-2-git-send-email-t.remmet@phytec.de>
 <20160710005614.GB29572@localhost> <20160713171303.GA136972@google.com>
Message-ID: <1cb6e1f9-b4b5-9097-5b02-96ac9559e8ae@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/16 20:13, Brian Norris wrote:
> On Sat, Jul 09, 2016 at 05:56:14PM -0700, Brian Norris wrote:
>> On Tue, Jul 05, 2016 at 11:32:30AM +0200, Teresa Remmet wrote:
>>> commit c9711ec5250b ("mtd: nand: omap: Clean up device tree support")
>>> removes the check for the old elm phandle binding.
>>
>> That seems like a silly breakage of backwards compatibility. Must have
>> overlooked that one, sorry.
>>
>>> Add it again to keep backward compatibility.
>>>
>>> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
>>
>> I think we should probably take this for v4.7, since the breaking commit
>> was only merged in v4.7-rc1. OMAP folks, any comment?
> 
> Applied to linux-mtd.git. I plan to send this to Linus for v4.7, since
> it's a DT regression, unless someone has a good reason not to.
> 

Sorry for the late reply as I was on vacation.
Thanks for the patch Teresa and thank you Brian for taking it into v4.7 :).

cheers,
-roger
