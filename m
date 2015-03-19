From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 19 Mar 2015 11:12:52 +0100
Subject: [PATCH] ARM: mvebu: Conform L2CC node with ePAPR specification
 by adding cache-level
In-Reply-To: <20150318171217.101ae9b0@free-electrons.com>
References: <1426610034-4204-1-git-send-email-gregory.clement@free-electrons.com>
 <20150318171217.101ae9b0@free-electrons.com>
Message-ID: <550AA124.40605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/2015 17:12, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Tue, 17 Mar 2015 17:33:54 +0100, Gregory CLEMENT wrote:
>> For L2 cache controller node, cache-level property is mandatory. Let's
>> add it to Armada 370 and Armada XP device tree.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


applied on mvebu/dt with Thomas tag

Thanks,

Gregory

> 
> Thanks,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
