From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Feb 2014 11:39:49 +0100
Subject: [PATCH v2 0/6] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
In-Reply-To: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
References: <20140204191648.29809.14611.stgit@dizzy-6.o2s.ch>
Message-ID: <20140205103949.GC3192@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Tue, Feb 04, 2014 at 08:24:13PM +0100, David Lanzend?rfer wrote:
> Hello
> The following patchset adds support for the SD/MMC host found in the Allwinner SoCs.
> It contains all the necessary modifications for clock environment and also the device
> tree script modification which add it to all the boards using it.
> The clock environment function needed for phase offset configuration has
> been proposed and implemented by Emilio.
> This patchset is the second attempt to send this driver upstream.
> I'm looking forward to the acceptance of this patchset into mainline.

I have four comments here:
  - Read Documentation/SubmittingPatches, especially Section 5 and 12
    (hints, you forgot the clock maintainers for your clock patches
    and you didn't put any signed-off-by tags)
  - You ignored pretty much all the comments that were made during the
    review of the first version. Go through
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/219339.html
    and address the comments that were made.
  - Each of your patches should compile. Fix the order of your
    patches.
  - Submit a v3, with the changes you made. Otherwise we have no way
    of knowing what have been fixed and what didn't

Looking forward for the next iteration!
Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/739e5515/attachment.sig>
