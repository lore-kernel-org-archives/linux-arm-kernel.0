From: raghumag@gmail.com (raghu MG)
Date: Tue, 19 May 2015 15:50:39 +0530
Subject: ARMADAXP MV78260 CPU-1:failed to come online
In-Reply-To: <20150519104936.3e5f6bc2@free-electrons.com>
References: <CAG1O52XwiW9a0+XS==vNAiKoYiVg7TR5XfYrQxHO7R089RWcfg@mail.gmail.com>
 <20150518202033.GH21807@lunn.ch>
 <20150518223019.70ccf639@free-electrons.com>
 <CAG1O52Uc0On7tGAp5Ae6bwmSt4S5rQZKcPGA9Dy7vy6y5DzS5A@mail.gmail.com>
 <20150519104936.3e5f6bc2@free-electrons.com>
Message-ID: <CAG1O52WQR_O0joDbSg9N78YBpSZRDd16-ArBfUzKM9hPtcRX6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas
That was quick.....Yes the append works fine..
I have to port drivers for the board now.

Thanks for the help..Will post queries if I  get into trouble on
ARMADAXP platform.

Anyways thanks  a ton :)

On Tue, May 19, 2015 at 2:19 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Raghu,
>
> On Tue, 19 May 2015 14:15:49 +0530, raghu MG wrote:
>
>> I am trying latest stable release from kernel.org -->linux-4.0.3.
>>
>> I have seen this issue in linux-3.10.39 & linux-3.10.32 for which
>> Marvell has provided lsp.
>>
>> This issue doesnt crop up in older version like linux-3.2.40 &
>> linux-3.2.52 with uImage
>>
>> Not sure but I think this is something do with zImage & device tree combination.
>
> Can you please try to boot with appended DTB? Some versions of the
> Marvell bootloader tend to do horrible modifications to the FDT, making
> assumptions that might be true with their Linux LSP, but not with the
> mainline kernel. Using appended DTB is a way of making sure that their
> bootloader will not touch the kernel DTB.
>
> Thanks,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
