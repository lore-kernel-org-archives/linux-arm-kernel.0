From: berndfaust@gmail.com (Bernd Faust)
Date: Sun, 23 Mar 2014 12:38:31 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140321173252.GL7528@n2100.arm.linux.org.uk>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de>
 <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
 <532B86A7.5010200@boundarydevices.com>
 <20140321011843.GG7528@n2100.arm.linux.org.uk>
 <CAOMZO5A+e+mHw1EG9t983ZG_KVL_O1r5UVwUU3JBsU5yPxOBsA@mail.gmail.com>
 <CAOMZO5CxjCHLrY0KTe4j=NiSU3CQVNZWhEAs33Le8ji3NAFETQ@mail.gmail.com>
 <CANBf9eNZB+BVBDkgWNxxGs-ndQ-mYCc6+bfVdS-8T-QLpSZ3GA@mail.gmail.com>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
Message-ID: <CANBf9ePuqFXXy+tsHdeuogPuVgN1OD2jswhvZ1qJYHC=Lu+N-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2014 18:32, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Mar 21, 2014 at 05:33:02PM +0100, Bernd Faust wrote:
>> I also tried the patch, but unfortunately it doesn't work for me either.
>> I get the same error as Robert Daniels. My target is a i.MX6 (Cortex A9,
>> single core) running Linux Kernel version 3.10.9-rt5+
>
> Hmm, rt kernels.  Does this happen without the rt patches applied?
>

On a kernel without RT patches the problem does not occur, so in my
case the problem seems to be introduced/triggered by the RT patches.
