From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 30 Mar 2012 22:24:20 +0200
Subject: [U-Boot] zImage and raw ramdisk support -- test
In-Reply-To: <CAOCHtYiewpJ6PERFP_O-0gXkkrQte1kL3m4za9=9ZaNBMgyqLg@mail.gmail.com>
References: <201203301738.57972.marek.vasut@gmail.com>
 <CAOCHtYiewpJ6PERFP_O-0gXkkrQte1kL3m4za9=9ZaNBMgyqLg@mail.gmail.com>
Message-ID: <201203302224.20196.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Robert Nelson,

> On Fri, Mar 30, 2012 at 10:38 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Guys,
> > 
> > I need final test on as much platforms as possible. Can you please run
> > these two following patches and tell me if they work with zImage and raw
> > ramdisk for you?
> > 
> > http://patchwork.ozlabs.org/patch/146848/
> > http://patchwork.ozlabs.org/patch/147440/
> > 
> > I can't promise they will make it to this release (I've been pestering WD
> > pretty thoroughly (sorry about that), though I'm starting to be unhappy
> > to merge this stuff at the verge of release myself).
> 
> Hi Marek,
> 
> These work great on my omap3 Beagle xM C / omap4 Panda, using a zImage
> and initramfs..
> 
> Just added the two appropriate board configs, to enable it..
> #define CONFIG_CMD_BOOTZ
> #define CONFIG_SUPPORT_RAW_INITRD
> 
> and used todays u-boot git head:
> http://git.denx.de/?p=u-boot.git;a=commit;h=7cb30b13f12077c7eec8ce2419cd96c
> d65ace8e2

And it makes u-boot about 20% cooler, doesn't it ;-)

Thanks a lot for your testing!

> Tested-by: Robert Nelson <robertcnelson@gmail.com>
> 
> Regards,

Best regards,
Marek Vasut
