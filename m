From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sun, 04 Oct 2009 12:55:25 +0100
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
In-Reply-To: <20091004112129.GA26794@n2100.arm.linux.org.uk>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>	<20091004011424.12578.79467.stgit@localhost.localdomain>
	<20091004112129.GA26794@n2100.arm.linux.org.uk>
Message-ID: <4AC88D2D.5030408@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sun, Oct 04, 2009 at 02:14:24AM +0100, Christian Gagneraud wrote:
>> In early days Technologic Systems fixed the 0x163 value in redboot
>> instead of 0x2a1, this patch allow to overwrite it.
> 
> This is where ensuring that the machine number is not hard coded into
> the boot loader, having it as a script-settable variable or a run-time
> configuration option is a win-win situation.
> 
> Patch is not suitable for the mainline kernel.

OK, fair enough. At least I tried! ;)

Chris.


> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
