From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 12 Mar 2013 17:04:01 +1300
Subject: [PATCH 1/6] arm: vt8500: Increase available GPIOs on arch-vt8500
In-Reply-To: <20130311163826.GJ4977@n2100.arm.linux.org.uk>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-2-git-send-email-linux@prisktech.co.nz>
 <20130311163826.GJ4977@n2100.arm.linux.org.uk>
Message-ID: <1363061041.23051.2.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 16:38 +0000, Russell King - ARM Linux wrote:
> On Sat, Mar 09, 2013 at 06:39:33PM +1300, Tony Prisk wrote:
> > With the inclusion of the pin control driver, more GPIO pins have been
> > identified on the arch-vt8500 SoCs requiring an increase in the available
> > GPIOs.
> 
> There is a patch from Maxime Ripard in February fixing the broken
> orering of these options.  It was sent to Arnd and Olof - but was it
> merged?  Arnd/Olof needs to merge for -rc and people need to take
> note of it (it will conflict for example with your patch.)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I was aware of the patch to reorder the gpio numbering, and my patch
originally reordered them as well then I realised I should undo it to
avoid complicating things.

Quite happy to rebase this on a later -rc once the original patch is
merged.

Regards
Tony P
