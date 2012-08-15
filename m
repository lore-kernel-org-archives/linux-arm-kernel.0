From: alanbutty12@gmail.com (Alan M Butler)
Date: Wed, 15 Aug 2012 09:36:57 +0100
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <20120814235653.GA22226@titan.lakedaemon.net>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
 <20120814235653.GA22226@titan.lakedaemon.net>
Message-ID: <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15 Aug 2012, at 00:56, Jason Cooper <jason@lakedaemon.net> wrote:

> On Tue, Aug 14, 2012 at 09:06:16PM +0100, Ownerx35 wrote:
>> I have created a patch and have tested it myself that create a board
>> setup file for the Iomega StoreCenter IX2-200, create a dts file and
>> insert the appropriate lines into the common.h, makefile,
>> makefile.boot, kconfig and board-ft files.
> 
> Awesome!
> 
>> But am unsure how to properly submit it should i just post it here? or
>> is there a specific place i should post?
> 
> Take a look at /path/to/linux_src/Documentation/SubmittingPatches .
> 
> If you prefer working with git, the two commands I use are format-patch
> and then send-email.
> 
> Assuming the board is ARM based (most likely), then you've found the
> correct list.
> 
> Just post the series here and we'll offer helpful comments ;-)
> 
> Also, please check MAINTAINERS for the directories you are changing and
> include the maintainers in the CC: or TO:.  Most likely, that'll be
> myself and Andrew Lunn (kirkwood / orion boards).
> 
> hth,
> 
> Jason.

Sorry i meant board-dt in the previous message and the name just getting used to the mail program on os x aswel. I have run through the checkpatch.pl script and it tells me there are no errors but i just found out a few minutes ago theres a fix for the 2 sata ports not working (on all kirkwood devices as far as i know) so i am going to test that now as it envolves modifying a line in the dts file.

Also it is defiantly an arm kirkwood device. My patch also does not modify any driver's or anything else just create's the appropriate file in the arch/am/boot/dts directory and the board config in the arch/arm/mach-kirkwood directory along with adding the lines to the appropriate files in that directory. So do i need to inform anyone else? the maintainers file is pretty long and i am unsure of what / who i am looking for in it.

It's also a single patch so i just copy and paste the patch text into a reply like this and send it?
