From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 25 Sep 2018 08:14:46 -0700
Subject: [PATCH 4/6] ARM: dts: imx51-zii-scu2-mezz: Disable the internal
 watchdog
In-Reply-To: <20180925151208.GF21282@dragon>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
 <1536696647-8228-4-git-send-email-festevam@gmail.com>
 <20180925151208.GF21282@dragon>
Message-ID: <CAHQ1cqH5Yh9XKTghH9wC+tMb3-49SdFnm6ra3XKS0hH_WBQpXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 8:12 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Sep 11, 2018 at 05:10:45PM -0300, Fabio Estevam wrote:
> > imx51-zii-scu2-mezz has an external watchdog in the environment
> > microcontroller, so disable the internal one.
> >
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
>
> @Andrey, are you okay with this one?
>

Yep, that's one of the boards that have RAVE SP MCU that implements
watchdog functionality there.

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks,
Andrey Smirnov
