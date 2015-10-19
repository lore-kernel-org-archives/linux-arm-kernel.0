From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 22:43:42 +0900
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <CANAwSgSd8sHDcmGmck=Em2H5WJzVWM28cbvs9z6CFgpuTY_Juw@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
 <561C4CEE.3050905@samsung.com>
 <CANAwSgRJ+5O-x61K9E_AxTZWQy3jJrKF5MiLtWRdUU29CCfa-Q@mail.gmail.com>
 <561C7DF1.6000609@samsung.com>
 <CANAwSgRBzFqHB98wSQnQu-ggGqRT2H6wC415wULXVhPg0uw_3A@mail.gmail.com>
 <561D9ACE.6050103@samsung.com>
 <CAGOxZ51uPkdGmCAs2Tc8_=YvkORJKdivN47vo1ZxkGQ-MY=-oQ@mail.gmail.com>
 <CAD=FV=Voh6Xh_naWQTaRPP8YUS2xJh7jfA+zYbH9QdVhmyZz9A@mail.gmail.com>
 <CANAwSgSd8sHDcmGmck=Em2H5WJzVWM28cbvs9z6CFgpuTY_Juw@mail.gmail.com>
Message-ID: <5624F38E.8030207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 19.10.2015 o 19:11, Anand Moon pisze:
> Hi Doug/ Krzysztof ,
> 
> 
> Thanks for clarifying all the background details on the mmc changes.
> 
> Here is what I would conclude from the previous mail chain's.
> 
> 1 Drop the cd-gpios changes. pinctrl-0 changes.

OK

> 
> 2 Fix the regulator changes for vmmc/vqmmc with disable of regulator-always-on;

Just fix all the comments for patch 2.

> 
> 3 Drop this UHS-I changes as if now.
> 
> Is this ok with you.

It's okay.

Best regards,
Krzysztof
