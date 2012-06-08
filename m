From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 8 Jun 2012 08:51:10 +0200
Subject: [PATCH] media: mx2_camera: Add YUYV output format.
In-Reply-To: <CAOMZO5CaW+pUmVrgDFT857eyaR8kjzcE89K4ZBwi8TF0f5dxaA@mail.gmail.com>
References: <1338905173-5968-1-git-send-email-javier.martin@vista-silicon.com>
 <CAOMZO5AnR9e9O+A+8zH+W+3pa0=cey=9wL0Oa2z+YrhYadvQ1w@mail.gmail.com>
 <CACKLOr28+2pQqOKyVP728kiD2BAnCzkMFgNL=059jmTpeFvQHg@mail.gmail.com>
 <CAOMZO5BA9pT0vwXT1zr+-fjHr5eT6eTYEzsKbrCs8rzxiQCwWg@mail.gmail.com>
 <CACKLOr1_pOSkMfo7xWMPd4qJvo8MgNa-dswWVKGBx=enaEB2CQ@mail.gmail.com>
 <CAOMZO5CaW+pUmVrgDFT857eyaR8kjzcE89K4ZBwi8TF0f5dxaA@mail.gmail.com>
Message-ID: <CACKLOr083hwix+C+0L+Gh93-j_XkekQZSMANxsXZJeJ4Pxm+Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 7 June 2012 19:35, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Javier,
>
> On Thu, Jun 7, 2012 at 5:30 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>
>> As i stated, the driver is still in an early development stage, it
>> doesn't do anything useful yet. But this is the public git repository
>> if you want to take a look:
>>
>> git repo: https://github.com/jmartinc/video_visstrim.git
>> branch: ?mx27-codadx6
>
> Thanks, I will take a look at your tree when I am back to the office next week.
>
> I also see that Linaro's tree has support for VPU for mx5/mx6:
> http://git.linaro.org/gitweb?p=landing-teams/working/freescale/kernel.git;a=summary
>
> ,so we should probably think in unifying it with mx27 support there too.
>
>>
>> FYI we are only interested on adding support for the encoding path of
>> the VPU, but we are trying our best to make it modular (as it is done
>> in Samsung's [1]), so that anyone can add decoding support later.
>
> Ok, sounds good.
>
>> By the way, you work for Freescale, don't you?
>
> Yes, correct.
>
>> We have a couple of issues with the i.MX27 VPU:
>>
>> 1- Firmware for the VPU is provided as a table of binary values inside
>> a source file which is licensed as GPL, however software is packaged
>> in a .tar.gz file that is marked as NDA. Do we have the right to
>> distribute this firmware with our products?

To address this issue it would be great if you, as a Freescale
employee, could send VPU firmware binary file to linux-firmware with a
LICENSE.xxxx file as well:

http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree

>> 2- There is a BUG in the firmware that marks P frames as IDR when it
>> should only be done to I frames. Would it be possible to have access
>> to the source code of the firmware in order to fix that problem?
>
> I will need to check this next week when I am back to the office.


Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
