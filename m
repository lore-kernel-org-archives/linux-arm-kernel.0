From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 29 Jul 2014 16:12:03 +0200
Subject: [PATCH 3/3] arm: dts: Add gta04a5 model
In-Reply-To: <589F7CA3-F245-4299-8E39-36A7FA9F3CBD@goldelico.com>
References: <1406577213-9642-1-git-send-email-marek@goldelico.com>
 <1406577213-9642-4-git-send-email-marek@goldelico.com>
 <CAOf5uwk=ctww=pP4Ae+1C6i-oOtiYTv2NJbj1GpuPwVSKXB4Hw@mail.gmail.com>
 <CAAfyv35jvhzvjCKMwrpa=RQ1JkfcmthCsGDzwLW9Y6bq3Ww_fg@mail.gmail.com>
 <CAOf5uw=Fm9FXEH5ESqDC8pGjMbn5VQ1+MyPJVXSqGh_9+JRLHw@mail.gmail.com>
 <1FA8171E-1B7A-4684-887E-11593BB9C29E@goldelico.com>
 <20140729124120.GS29045@atomide.com>
 <589F7CA3-F245-4299-8E39-36A7FA9F3CBD@goldelico.com>
Message-ID: <CABxcv=n7g8c2ePGKgu_0Y35iearcRoAj9ZH5jDWY9nE+1uUKnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 29, 2014 at 3:03 PM, Dr. H. Nikolaus Schaller
<hns@goldelico.com> wrote:
> Hi,
>> So what's the conclusion? Are changes needed to this patch
>> series or not?
>
> I advocate that no changes are needed.
>

I agree with Dr. H. Nikolaus on this regard. A DeviceTree should be a
description of the hardware and if two hardware platforms differs,
then we need two different DTS.

Lately I'm seeing some attempts to abuse u-boot's fdt command, u-boot
should only modify the strictly necessary like the /chosen branch.
Allowing u-boot to mangle the FDT before passing to the kernel just to
avoid some DT duplication doesn't sound like a good idea IMHO.

> BR,
> Nikolaus
>
> --

Best regards,
Javier
