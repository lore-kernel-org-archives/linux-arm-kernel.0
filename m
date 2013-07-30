From: david@lang.hm (David Lang)
Date: Mon, 29 Jul 2013 17:41:11 -0700 (PDT)
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <20130729172339.GT29916@titan.lakedaemon.net>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
 <20130729172339.GT29916@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.02.1307291739150.13736@nftneq.ynat.uz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jul 2013, Jason Cooper wrote:

> 
>>
>> I don't think that siblings have any defined order in DT.  If reading a
>> device tree, there's no guarantee you get nodes or properties out in the
>> same order as the original .dts file.
>
> That's why I raised the point.  If people think encoding initialization
> order in the DT is a good idea, then we should change the dtc so it
> compiles/decompiles in the same order.

if you make the initializaiton order 'magicly' correct by following the order of 
the flat representation, how do you reflect the case where initialization can be 
overlapped for different devices?

you are just trading one side of the problem for the other.

David Lang
