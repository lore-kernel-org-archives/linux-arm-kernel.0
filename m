From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 10:04:06 +0000
Subject: [PATCH v2 02/20] ARM: LPAE: Factor out 2-level page table
	definitions into separate files
In-Reply-To: <AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
	<20101115233129.GG31421@n2100.arm.linux.org.uk>
	<AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
Message-ID: <20101116100406.GB12891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 09:14:52AM +0000, Catalin Marinas wrote:
> > Of couse, I now have patches for this and my other points... will sort
> > them out into a series in the next few days.
> 
> Thanks.

BTW, don't post another round of patches just because you've had _some_
comments back - your v2 patches are still being looked through, your v3
patches haven't even been looked at yet.

It took some 4 hours for the mailing list to get through last nights
posting frenzy that it really isn't worth overloading - is it really
worth bringing the list server to its knees when the job is only half
done?
