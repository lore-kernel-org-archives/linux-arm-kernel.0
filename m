From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 May 2014 10:01:17 +0100
Subject: arm64 entry point
In-Reply-To: <1400195191.12756.9.camel@smoke>
References: <1400195191.12756.9.camel@smoke>
Message-ID: <20140516090116.GB12341@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 12:06:31AM +0100, Geoff Levand wrote:
> Hi,

Hi Geoff,

> There is some discrepancy between what booting.txt says and what our
> linker script defines as the kernel entry point.
> 
> Here is booting.txt:
> 
>   The primary CPU must jump directly to the first instruction of the
>   kernel image.
> 
> And the linker script:
> 
>   ENTRY(stext)
> 
> Should we change booting.txt, or the linker script?

We should fix the linker script to have the correct entry address.

Care to send a patch?

Will
