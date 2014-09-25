From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Sep 2014 13:06:26 -0400
Subject: [PATCH v4 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <1411655363.4026.13.camel@joe-AO725>
References: <1411653805-29257-1-git-send-email-santosh.shilimkar@ti.com>	
 <1411653805-29257-3-git-send-email-santosh.shilimkar@ti.com>
 <1411655363.4026.13.camel@joe-AO725>
Message-ID: <54244B92.4020004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 10:29 AM, Joe Perches wrote:
> On Thu, 2014-09-25 at 10:03 -0400, Santosh Shilimkar wrote:
>> From: Sandeep Nair <sandeep_n@ti.com>
>>
>> The network coprocessor (NetCP) is a hardware accelerator that processes
>> Ethernet packets. NetCP has a gigabit Ethernet (GbE) subsystem with a ethernet
>> switch sub-module to send and receive packets. NetCP also includes a packet
>> accelerator (PA) module to perform packet classification operations such as
>> header matching, and packet modification operations such as checksum
>> generation. NetCP can also optionally include a Security Accelerator(SA)
>> capable of performing IPSec operations on ingress/egress packets.
> 
> Some checkpatch trivia you might consider:
Sure. I fold that in. Thanks !!

regards,
Santosh
