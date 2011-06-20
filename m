From: skacore.systems@gmail.com (Skacore Systems)
Date: Mon, 20 Jun 2011 17:20:02 +0200
Subject: [PATCH] s3c2410_udc: fix custom UDC command handling
In-Reply-To: <20110620151522.GN14262@legolas.emea.dhcp.ti.com>
References: <BANLkTimWM2oew2f9uWxoD1kw1=2bSYFFuw@mail.gmail.com>
	<Pine.LNX.4.44L0.1106201105430.2113-100000@iolanthe.rowland.org>
	<20110620151522.GN14262@legolas.emea.dhcp.ti.com>
Message-ID: <BANLkTi=5S6bWs3jr9hTsg2=LXh4xKAprUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been exactly following
http://www.kernel.org/doc/Documentation/SubmittingPatches:

To create a patch for a single file, it is often sufficient to do:

	SRCTREE= linux-2.6
	MYFILE=  drivers/net/mydriver.c

	cd $SRCTREE
	cp $MYFILE $MYFILE.orig
	vi $MYFILE	# make your change
	cd ..
	diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch

And that's what I've done. What do you think is wrong with it ???

Vilo


On Mon, Jun 20, 2011 at 5:15 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Jun 20, 2011 at 11:07:51AM -0400, Alan Stern wrote:
>> On Mon, 20 Jun 2011, Viliam Mateicka wrote:
>>
>> > So, will somebody at least react/reply (or just fix) ?
>>
>> Have some patience. ?You did not address your email message to either
>> of the driver's authors or to the current Gadget maintainer. ?Also,
>> David Brownell is deceased and Greg KH is on vacation.
>
> besides, the patch formatting is wrong. That was noted before and the
> reply was less than acceptably polite, so unless the patch comes
> Perfect(TM), I'm not looking into it.
>
> --
> balbi
>
