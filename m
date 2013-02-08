From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 8 Feb 2013 14:02:54 +0000
Subject: OMAP baseline test results for v3.8-rc6
In-Reply-To: <87ehgqlxca.fsf@dell.be.48ers.dk>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
 <20130207083217.GA15462@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
 <87ehgqlxca.fsf@dell.be.48ers.dk>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC06EB2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 19:30:21, Peter Korsgaard wrote:
> >>>>> "Paul" == Paul Walmsley <paul@pwsan.com> writes:
> 
> Hi,
> 
>  Paul> So what I'd like to know is why it doesn't work with >= v3.8-rc1
>  Paul> with an appended DTB:
> 
>  Paul> http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/boot/am335xbone/am335xbone_log.txt
> 
>  Paul> The point is to try to minimize bootloader dependencies.
> 
>  Paul> Haven't had the chance to try Felipe's suggestion yet re fdt_high.
> 
> That shouldn't matter when using appended dtb.
> 

That's correct, relocating dtb should not matter for appended DTB kernel 
image.

I am trying now with appended DTB, 

Thanks,
Vaibhav
