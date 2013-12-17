From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 17 Dec 2013 14:51:55 +0800
Subject: sdhci-esdhc-imx - power management supported
In-Reply-To: <CACUGKYNj3hBaDfzO7o2VuoFLCvQZdutFV=Q5QrzLcBF8Y2cfRQ@mail.gmail.com>
References: <CACUGKYNj3hBaDfzO7o2VuoFLCvQZdutFV=Q5QrzLcBF8Y2cfRQ@mail.gmail.com>
Message-ID: <CAA+hA=Tz6QOa9grNzS35F_Vs9PoqcgUMSji6F7ABVwr9uX2qfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Tue, Dec 17, 2013 at 3:11 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Dong,
>
> I saw your sdhci-esdhc-imx driver supported the power management. I am
> assuming you have a working power management on your kernel. I would
> like to know which kernel has a working power management for iMX6?.
>

Chris' tree already has imx rpm patches for uSDHC.
git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
You can refer to it.

Regards
Dong Aisheng

> Regards,
>
> john
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
