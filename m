From: trini@ti.com (Tom Rini)
Date: Tue, 17 Jun 2014 10:58:24 -0400
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <20140617125640.GC3705@n2100.arm.linux.org.uk>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk> <53A03675.1000908@ti.com>
 <20140617125640.GC3705@n2100.arm.linux.org.uk>
Message-ID: <53A05790.7090803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2014 08:56 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 17, 2014 at 08:37:09AM -0400, Tom Rini wrote:
>> On 06/17/2014 05:09 AM, Russell King - ARM Linux wrote:
>>> A good way that this could have been done is to put an I2C EEPROM on
>>> each cape, and have that store the DT fragment.  The boot loader could
>>> have then read that from each cape, and used that information to build
>>> up the final DT.  Why this hasn't been thought of, considering that the
>>> kernel has been moving towards DT for years, is quite unbelievable.
>>
>> I had actually talked about this a long while back (face to face) with
>> people, but the problem was (and still kind of is) the bindings
>> changing, etc.
> 
> And that's a strong argument for having stable bindings - or at the
> very least, ensuring that new bindings which are compatible with older
> versions.

Yes.  This was a few years back (a bit before the first beaglebone was
public) so before we had really pushed up on some level of binding
stability.

-- 
Tom
