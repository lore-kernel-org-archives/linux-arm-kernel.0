From: jason.wessel@windriver.com (Jason Wessel)
Date: Wed, 20 Jan 2010 11:01:14 -0600
Subject: [PATCH 20/40] arm,kgdb: Add hook to catch an oops with debugger
In-Reply-To: <20100120160319.GC27507@n2100.arm.linux.org.uk>
References: <20100114174821.GB21385@n2100.arm.linux.org.uk>
	<4B4F7EC2.6030000@windriver.com>
	<20100114204647.GE21385@n2100.arm.linux.org.uk>
	<4B54706C.20202@windriver.com>
	<20100120160319.GC27507@n2100.arm.linux.org.uk>
Message-ID: <4B5736DA.40305@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Jan 18, 2010 at 08:30:04AM -0600, Jason Wessel wrote:
>   
>> That being said, you patch works for the purpose of catching the
>> exception and returning with or without the addition of an earlier
>> return before bust_spinlocks() which I had proposed.
>>     
>
> So does that mean I can have an acked-by for the patch?
>   
Absolutely.

Jason.

Acked-by: Jason Wessel <jason.wessel@windriver.com>
