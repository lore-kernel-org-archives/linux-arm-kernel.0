From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 03 Feb 2016 11:44:38 +0100
Subject: [PATCH 07/10] arm64: dts: add the Marvell Armada 3700 family and
 a development board
In-Reply-To: <20160202183436.GE29778@leverpostej> (Mark Rutland's message of
 "Tue, 2 Feb 2016 18:34:36 +0000")
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-8-git-send-email-gregory.clement@free-electrons.com>
 <20160202183436.GE29778@leverpostej>
Message-ID: <877fim5azt.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
 
 On mar., f?vr. 02 2016, Mark Rutland <mark.rutland@arm.com> wrote:

>> +	memory {
>> +		device_type = "memory";
>> +		/* use only 256 MB on the 512 MB available */
>> +		reg = <0x00000000 0x00000000 0x00000000 0x10000000>;
>> +	};
>
> It would be good to comment as to why we can't use 256M of the memory.

Actually the comment is wrong and the size too, we do use the 512MB.

I will fix it

Thanks,

Gregory

>
> Otherwise this looks fine.
>
> Mark.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
