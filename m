From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Wed, 20 Feb 2013 17:25:22 +0800
Subject: [PATCH 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAP1dx+xT+cGswcsW54WxNq7fDVvgqq1M-ZW4r_8h8ppfVh3yNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Really glad to see this clean up patch series.
Thanks for your work.

On 20 February 2013 15:08, Shawn Guo <shawn.guo@linaro.org> wrote:
> First of all, thanks to Stephen for getting CPP pre-processor support
> on DTC.

I want to express my thanks to Stephen too.

>
> The series is an action of discussion [1].  It utilizes the DTC
> pre-processing feature to move those huge mount of data about pin
> from pinctrl driver into device tree.
>

It's good we start this work now.

Regards
Dong Aisheng
