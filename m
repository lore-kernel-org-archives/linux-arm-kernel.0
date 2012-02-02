From: axel.lin@gmail.com (Axel Lin)
Date: Thu, 2 Feb 2012 09:59:28 +0800
Subject: [PATCH RESEND] ARM: pxa: fix error handling in
 pxa2xx_drv_pcmcia_probe
In-Reply-To: <CAN1soZyatf2u4fVk-=U_Sz4wcVwP7qFaiZK4CR3rosbXeQObvA@mail.gmail.com>
References: <1324974344.2351.5.camel@phoenix>
 <CAMPhdO_QL3ahf4+F70Bg7FHKq5mrbbofN_BTz8dpcBLea9BNAw@mail.gmail.com>
 <25B60CDC2F704E4E9D88FFD52780CB4C05EC64DBD3@SC-VEXCH1.marvell.com>
 <CAMPhdO8=L1KGmn_OihoMmMWNDahZ5+3u7M+BNuT3FcSfExHm1w@mail.gmail.com>
 <CAN1soZyatf2u4fVk-=U_Sz4wcVwP7qFaiZK4CR3rosbXeQObvA@mail.gmail.com>
Message-ID: <CAF+7xW=VmaOATC1-J3u=s7pjuK-xefo+5zzZ3GpqVot7JJOfDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> If it fails, it will jump to err1 anyway. The check there is redundant.
>>
> Applied

Hi Haojian,
This patch is not (yet) upstream.
Could you help to check it again.

Thanks,
Axel
