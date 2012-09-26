From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 26 Sep 2012 14:04:36 +0800
Subject: [GIT PULL][for 3.7] pull request on dt2 branch from arch-pxa
In-Reply-To: <20120922060817.GJ32245@quad.lixom.net>
References: <CAN1soZxC_KovdgENmsSQcUFkK2VgirkaKKSx1=RjLhULATw=+Q@mail.gmail.com>
 <20120922060817.GJ32245@quad.lixom.net>
Message-ID: <CAN1soZwArV88LU=p1mu5UQKjd0zVPTkM5azDrPvBFXRtL+8FfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2012 at 2:08 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 21, 2012 at 04:24:58PM +0800, Haojian Zhuang wrote:
>> Hi Olof & Arnd,
>>
>> Please help to merge dt2 branch from arch-pxa git tree.
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
>>   git://github.com/hzhuang1/linux.git dt2
>>
>> for you to fetch changes up to 37586e0b9cadd1072196c3cca8ea8559b91b1605:
>>
>>   ARM: dt: mmp-dma: add binding file (2012-09-21 15:51:26 +0800)
>>
>> ----------------------------------------------------------------
>> Zhangfei Gao (1):
>>       ARM: dt: mmp-dma: add binding file
>
> What happened to the rest of this series? It makes more sense to merge the
> driver using the binding at the same time as the binding itself, so let's hold
> off until the driver is reviewed and ready to go in too (or, if you merge that
> through a different path, the binding could/should go with it there).
>
>
> -Olof

Vinod merges the rest of the patch series into his dma tree except for this one.
I have to merge this one.

http://www.spinics.net/lists/arm-kernel/msg195141.html

Would you like to merge it into arm-soc tree?

Regards
Haojian
