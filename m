From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 05 Oct 2016 17:35:51 +0200
Subject: [PATCH] arm64: dts: marvell: Add definition for the Globalscale
 Marvell ESPRESSOBin Board
In-Reply-To: <20161005172837.5ea130a1@free-electrons.com> (Thomas Petazzoni's
 message of "Wed, 5 Oct 2016 17:28:37 +0200")
References: <20161005142734.18995-1-romain.perier@free-electrons.com>
 <87fuoaygie.fsf@free-electrons.com>
 <20161005172837.5ea130a1@free-electrons.com>
Message-ID: <87bmyyyfjc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., oct. 05 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Wed, 05 Oct 2016 17:14:49 +0200, Gregory CLEMENT wrote:
>
>> > +	memory {
>> > +		device_type = "memory";  
>> 
>> 
>> According to the kickstarter page the boards will came with different
>> amount of memory (from 512MB to 2GB). So we could put a comment
>> here about tuning this value depending of the board.
>
> U-Boot does this tuning automatically, so there is no need for the user
> to tune anything here.

Great!

It was not the case with the first Armada XP and 370 boards, but at this
time we appended the dtb to the kernel and the U-Boot on these board was
not dt capable.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
