From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 22 Nov 2012 08:05:48 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq multiplatform changes for v3.8
In-Reply-To: <20121121200144.GD15213@quad.lixom.net>
References: <CAHTX3d+bqMnsWxQp3GAmprSDzNB18otT3SrPi5MkA+d8006Aww@mail.gmail.com>
 <20121121200144.GD15213@quad.lixom.net>
Message-ID: <CAHTX3dKm_=VaL=14vRr6+jGO2wrDXfW1asjXuZz0yeO0axZnbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2012/11/21 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Wed, Nov 21, 2012 at 04:51:07PM +0100, Michal Simek wrote:
>> Hi Olof and Arnd,
>>
>> based on my chat with Olof today I have created new branch
>> with 4 patches which move zynq to multiplatform.
>>
>> This branch depends on arm-soc devel/debug_ll_init branch because
>> we needed Rob's "ARM: implement debug_ll_io_init()"
>> (sha1: afaee03511ba8002b26a9c6b1fe7d6baf33eac86)
>> patch.
>>
>> This branch also depends on zynq/dt branch because of previous major
>> zynq changes.
>> zynq/cleanup branch is subset of zynq/dt.
>>
>> That's why I have merged devel/debug_ll_init branch with zynq/dt and
>> add 4 patches
>> on the top of it.
>
> Nice work.
>
> This looks quite reasonable, is small and self-contained and doesn't really
> affect anyone outside of zynq. So I've pulled into next/multiplatform for 3.8.
>
> As part of this, the next/* branches have been somewhat reordered, since
> multiplatform now includes next/dt contents I've moved it down below there. It
> shouldn't affect much since no other branch pulls in next/multiplatform
> contents.

Thanks a lot,
Michal
