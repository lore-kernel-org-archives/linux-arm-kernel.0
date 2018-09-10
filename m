From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 10 Sep 2018 09:43:27 +0100
Subject: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
Message-ID: <64fbd7ca-48a8-7cb0-af3a-131ee61aef5a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/09/18 02:18, Olof Johansson wrote:
> Hi,
> 
> On Fri, Aug 3, 2018 at 10:53 AM, Jolly Shah <jolly.shah@xilinx.com> wrote:
>> From: Rajan Vaja <rajanv@xilinx.com>
>>
>> Add ZynqMP firmware IOCTL API to control and configure
>> devices like PLLs, SD, Gem, etc.
>>
>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> 
> This patch worries me somewhat. It's a transparent pass-through ioctl
> driver. Is there a spec available for what the implemented IOCTLs are?
> 
> Should some of them be proper drivers instead of an opaque
> pass-through like this? Could some of them have stability impact on
> the platform such that there are security concerns and the list of
> arguments should somehow be sanitized?
> 
> What's the intended usecase anyway? Just a debug tool during
> development, or something that you expect heavy use of by some
> userspace middleware?
> 

Thanks for pointing this out. My earlier attempts were ignored[1]
and I gave up.

-- 
Regards,
Sudeep

[1] https://lkml.org/lkml/2018/5/10/298
