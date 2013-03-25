From: dianders@google.com (Doug Anderson)
Date: Mon, 25 Mar 2013 09:56:25 -0700
Subject: [PATCH] mmc: dwmmc: let device core setup the default pin
 configuration
In-Reply-To: <CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
References: <1362571461-14570-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=W8E=0C8_QZ3d44caq6EOvBpTkX0Ng86niQuN4B-cnHiw@mail.gmail.com>
Message-ID: <CAD=FV=Uy1dQMAxgh_ncxfsQVMDp4Da3inLTvgbJFhyhFLjVWrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Mon, Mar 11, 2013 at 10:53 AM, Doug Anderson <dianders@google.com> wrote:
> It would be good to address Seungwon Jeon's comments (change prefix to
> dw_mmc and remove setup_bus), but in general this looks good to me,
> so...

Are you planning on doing this?  I noticed that Chris pulled your
sdhci-s3c change in recently but apparently skipped this one since it
had outstanding comments.  Can you address comments and re-send?  This
is blocking pinmux dts stuff from landing (I think) and that blocks a
lot of other things from landing.

The comments are pretty trivial, so I could always fix them and
re-send myself, but it would be better if you could do it...  :)

-Doug
