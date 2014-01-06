From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 06 Jan 2014 18:02:50 +0100
Subject: [PATCH v3 0/2] Fix i2c bus hang on A0 version of the Armada XP
 SoCs
In-Reply-To: <20140106165918.GC13111@lunn.ch>
References: <1389004820-30230-1-git-send-email-gregory.clement@free-electrons.com>
 <20140106165918.GC13111@lunn.ch>
Message-ID: <52CAE1BA.6050706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2014 17:59, Andrew Lunn wrote:
> On Mon, Jan 06, 2014 at 11:40:18AM +0100, Gregory CLEMENT wrote:
>> Hi,
>>
>> This the 3rd (and I hope last) version of the series fixing the i2c
>> bus hang on A0 version of the Armada XP SoCs. It occurred on the early
>> release of the OpenBlocks AX3-4 boards. Indeed the first variants of
>> Armada XP SoCs (A0 stepping) have issues related to the i2c controller
>> which prevent to use the offload mechanism and lead to a kernel hang
>> during boot.
> 
> Hi Gregory
> 
> Tested on my OpenBlocks AX3-4 with an A0 SoC.
> 

Great! Thanks!

> Tested-by: Andrew Lunn <andrew@lunn.ch>

I will let Jason add your tested-by flag when he will get the patches

> 
> Thanks
> 	   Andrew
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
