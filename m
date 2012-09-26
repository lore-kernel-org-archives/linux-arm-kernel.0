From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 26 Sep 2012 14:05:16 +0800
Subject: [GIT PULL][for 3.6] pull request on fixes branch from arch-pxa
In-Reply-To: <20120922061240.GK32245@quad.lixom.net>
References: <CAN1soZwLHZTudFVMQWaE43TPPtsGxYDZQSYfkkY1svVwbfSaUw@mail.gmail.com>
 <20120922061240.GK32245@quad.lixom.net>
Message-ID: <CAN1soZyn3J3a4e+MerKr_Sycjvp4+bCr3EtxHgwgtut-HEepoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 2:12 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 21, 2012 at 04:26:56PM +0800, Haojian Zhuang wrote:
>> Hi Olof & Arnd,
>>
>> Please help to merge fixes branch in arch-pxa git tree.
>>
>> Regards
>> Haojian
>>
>> The following changes since commit 5698bd757d55b1bb87edd1a9744ab09c142abfc2:
>>
>>   Linux 3.6-rc6 (2012-09-16 14:58:51 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/hzhuang1/linux.git fixes
>>
>> for you to fetch changes up to e09a716490dbce0b9b7d132d191f1f8785cb5df2:
>>
>>   ARM: pxa: fix return value check in pxa2xx_drv_pcmcia_probe()
>> (2012-09-21 15:33:58 +0800)
>>
>> ----------------------------------------------------------------
>> Wei Yongjun (1):
>>       ARM: pxa: fix return value check in pxa2xx_drv_pcmcia_probe()
>
> Hi,
>
> This doesn't look critical for 3.6, since the bug has been there a long time.
> I'll queue it up in next/fixes-non-critical for 3.7 instead.
>
> If you disagree, let me know and I'll consider sending it up sooner.
>
>
> Thanks,
>
> -Olof

I'm OK to merge it into 3.7.

Thanks
Haojian
