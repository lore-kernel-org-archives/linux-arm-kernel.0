From: otavio@ossystems.com.br (Otavio Salvador)
Date: Wed, 4 Sep 2013 23:04:57 -0300
Subject: [PATCH v2 3/4] ARM: imx6sl: add imx6sl iomux-gpr field define
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE01689ED6@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
 <1378182385-9205-4-git-send-email-B38611@freescale.com>
 <CAP9ODKqD05+S6HBnbBw-5Hs7NYVHRDJf014stSQ_AVeaYzVV+Q@mail.gmail.com>
 <9848F2DB572E5649BA045B288BE08FBE01689ED6@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <CAP9ODKoU2f1vOerkYvvT1DNdz3Waj1u0hUBALGQ0TaLsbMDGbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 4, 2013 at 11:01 PM, Duan Fugang-B38611
<B38611@freescale.com> wrote:
> From: otavio.salvador at gmail.com [mailto:otavio.salvador at gmail.com] On Behalf Of Otavio Salvador
> Data: Thursday, September 05, 2013 9:45 AM
>
>> To: Duan Fugang-B38611
>> Cc: Shawn Guo; devicetree at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH v2 3/4] ARM: imx6sl: add imx6sl iomux-gpr field define
>>
>> On Tue, Sep 3, 2013 at 1:26 AM, Fugang Duan <B38611@freescale.com> wrote:
>> > Add imx6sl iomux-gpr register field define in "imx6q-iomuxc-gpr.h"
>> > header file, which is not fully define all iomux-gpr registers and
>> > fields, only add fec related macro define.
>> >
>> > Signed-off-by: Fugang Duan  <B38611@freescale.com>
>>
>> The 'q' in the header filename is misleading; wouldn't be better to have
>> it named imx6-iomuxc-gpr.h than?
>>
> Yes, since there have many same macro define and register define, we put the iomux-gpr header file
> To one. I will submit one patch to rename the header file to imx6-iomuxc-gpr.h.

Great; thanks! :-)

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
