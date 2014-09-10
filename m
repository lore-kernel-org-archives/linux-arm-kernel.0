From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 10 Sep 2014 16:40:57 +0100
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <20140910145818.GG12361@n2100.arm.linux.org.uk>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
 <20140910145818.GG12361@n2100.arm.linux.org.uk>
Message-ID: <1410363657.23973.48.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-10 at 15:58 +0100, Russell King - ARM Linux wrote:
> So, I'll then be asking ARM to provide updated instructions on how to
> boot the CT9x4 with DT... 

The same version (although different build) of the Boot Monitor you have
got for CA15_A7 (a.k.a. TC2) is able to boot CA9x4 with DT. It has got
the same limitations though, namely no TFTP support, if this is your
main concern (there is no ARM-provided uboot for TC2 either).

If you are willing to perform firmware upgrade on the A9 tile, I'm happy
to help you with this.

Pawel
