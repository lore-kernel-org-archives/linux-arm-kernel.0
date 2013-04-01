From: dianders@google.com (Doug Anderson)
Date: Mon, 1 Apr 2013 11:42:31 -0700
Subject: [PATCH] mmc: dwmmc: let device core setup the default pin
 configuration
In-Reply-To: <CAD=FV=Uy1dQMAxgh_ncxfsQVMDp4Da3inLTvgbJFhyhFLjVWrg@mail.gmail.com>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
 <CAD=FV=Uy1dQMAxgh_ncxfsQVMDp4Da3inLTvgbJFhyhFLjVWrg@mail.gmail.com>
Message-ID: <CAD=FV=Vxh9+qpAmoLuALCOZJCLTfga0WdCf=P+heOmbkDY=Aww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Mon, Mar 25, 2013 at 9:56 AM, Doug Anderson <dianders@google.com> wrote:
> Are you planning on doing this?  I noticed that Chris pulled your
> sdhci-s3c change in recently but apparently skipped this one since it
> had outstanding comments.  Can you address comments and re-send?  This
> is blocking pinmux dts stuff from landing (I think) and that blocks a
> lot of other things from landing.
>
> The comments are pretty trivial, so I could always fix them and
> re-send myself, but it would be better if you could do it...  :)

I didn't hear anything last week and it's getting pretty late in the
process.  I'll post something tomorrow if I don't hear from you...

-Doug
