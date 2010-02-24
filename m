From: prashantsmailcenter@gmail.com (Prashant Bhole)
Date: Wed, 24 Feb 2010 15:08:38 +0530
Subject: large page support for IOP331
In-Reply-To: <20100224091111.GA7598@n2100.arm.linux.org.uk>
References: <9ff69a5d1002240100r708381ceha1ca29f2bd6f18b@mail.gmail.com>
	<20100224091111.GA7598@n2100.arm.linux.org.uk>
Message-ID: <9ff69a5d1002240138r6f7089c0o670f856a4ab3536f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 2:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 24, 2010 at 02:30:30PM +0530, Prashant Bhole wrote:
>> Is there any support of large page for arm architecture?
>
> The short answer is no.
>
> The long answer is that to have 16K pages, it causes bigger problems
> with the 2nd level page tables, which from the hardware perspective
> are only 256 per L1 entry, but are required to be in unique pages.
>

But we have 64 bit memory subsystem for IOP331 and
IOP331 developer's manual:

http://download.intel.com/design/iio/manuals/27394202.pdf

Page number 452, Table 218 says that we can have 8K and 16K
pages. Please correct me if I am wrong

-- 
~p~r~a~s~h~a~n~t~
