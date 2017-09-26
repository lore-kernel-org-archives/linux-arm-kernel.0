From: david@lechnology.com (David Lechner)
Date: Tue, 26 Sep 2017 11:28:39 -0500
Subject: [PATCH] ARM: davinci_all_defconfig: enable CMA options
In-Reply-To: <b9cbe510-112e-410c-33e1-4e4749b5fcfa@ti.com>
References: <20170920180132.4373-1-s-anna@ti.com>
 <758ebb8d-cdf5-4cdc-253b-b1eb8e2f7c61@ti.com>
 <52fd708b-8497-8d5d-262b-f78ecf068d87@ti.com>
 <e6232a0b-c2c2-2d20-758e-8b38e65091d7@ti.com>
 <158a7e84-dd66-e861-544d-172b2d3723ec@ti.com>
 <ba1bb5c3-a524-8ee1-6730-e61047dec440@lechnology.com>
 <b9cbe510-112e-410c-33e1-4e4749b5fcfa@ti.com>
Message-ID: <0b2d3921-b58b-6dbd-a8c1-d0b9b6678370@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2017 04:56 AM, Sekhar Nori wrote:
> Hi David,
> 

>>
>> I am interested in using remoteproc on LEGO MINDSTORMS EV3 to implement
>> I2C and UART in the PRU.
> 
> Do note that the remoteproc driver being discussed here is the DSP
> remoteproc driver. TI releases have a remoteproc driver that talks to
> PRUSS[1], but that has not been used to talk to PRUSS on OMAP-L138. And
> AFAIK, there is no one working towards that in TI as well.
> 
> Thanks,
> Sekhar
> 
> [1]
> http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/tree/drivers/remoteproc/pru_rproc.c?h=ti-linux-4.9.y
> 

Darn. I've used pru_rproc on the BeagleBone. One more thing for the EV3 
list ;-).
