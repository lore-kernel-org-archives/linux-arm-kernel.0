From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 30 Jul 2017 21:27:15 +0300
Subject: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
In-Reply-To: <1501355870-13960-1-git-send-email-david@lechnology.com>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
Message-ID: <CAHp75Ve=f_vpktMMGNx1PdhaqRkigdCUNArg==XWxkU3ykTw0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
> working. But, most of the content here is building up the infrastructure to do
> that.
>
> The controller used in the EV3 uses MIPI commands, but it uses a different
> memory layout. The current tinydrm stuff is hard-coded for RGB565, so most
> of the patches are adding support for other memory layouts.
>
> I've also made the one existing tinydrm driver generic so that it can work for
> any MIPI display rather than copying a bunch of boiler-plate code for each
> panel and/or controller.
>
> Once all of this is done, it is really easy to add a new panel. :-)

Perhaps pathes are good, but logically completely incorrect.

-- 
With Best Regards,
Andy Shevchenko
