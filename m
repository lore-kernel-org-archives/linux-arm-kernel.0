From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Jan 2015 18:47:45 +0100
Subject: [PATCH v4 07/12] ARM: mvebu: Add Armada 385 Access Point
 Development Board support
In-Reply-To: <20150108184416.3feb0e02@free-electrons.com>
References: <1420738694-6163-1-git-send-email-gregory.clement@free-electrons.com>	<1420738694-6163-8-git-send-email-gregory.clement@free-electrons.com>
 <20150108184416.3feb0e02@free-electrons.com>
Message-ID: <54AEC2C1.2080408@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 08/01/2015 18:44, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu,  8 Jan 2015 18:38:09 +0100, Gregory CLEMENT wrote:
> 
>> +#include "armada-385.dtsi"
> 
> Is it an Armada 385 or an Armada 388 ?

I checked it and there is no SATA ports on the board and the SoC presented
itself as an Armada 385: the revision ID is 0x6820.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
