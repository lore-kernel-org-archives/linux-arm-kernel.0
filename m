From: conqrx@gmail.com (=?ISO-8859-1?B?TW9sbuFyIEfhYm9y?=)
Date: Fri, 25 Nov 2011 12:35:03 +0100
Subject: Porting the 2.6.38 linux kernel to ARM11 MPcore
In-Reply-To: <20111123175157.GH9581@n2100.arm.linux.org.uk>
References: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
 <20111123175157.GH9581@n2100.arm.linux.org.uk>
Message-ID: <CAK-0apbfyYUiH_GCCzHn0o3Rbe55Rh7JbQcY6j3+FNdOzpmZ+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Nov 18, 2011 at 12:54:42PM +0100, Moln?r G?bor wrote:
>> <5>Linux version 2.6.38-rc8 (VirtualBox) (gcc version 4.5.2 (Sourcery
>> G++ Lite 2011.03-41) ) #6 Wed Nov 9 21:59:29 CET 2011
>> <4>CPU: ARMv6-compatible processor [410fb025] revision 5 (ARMv7), cr=08c5387f"
>> <4>CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
>> <4>Machine: ARM-RealView PB11MPCore
>> <5>Ignoring RAM at c0000000-c04fffff (vmalloc region overlap).
>
> This tells me your PHYS_OFFSET is set incorrectly.
>

Indeed it is, thank you!
