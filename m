From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 25 Sep 2018 08:13:09 -0700
Subject: [PATCH 2/6] ARM: dts: imx51-zii-scu3-esb: Disable VPU
In-Reply-To: <20180925150727.GD21282@dragon>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
 <1536696647-8228-2-git-send-email-festevam@gmail.com>
 <20180925150727.GD21282@dragon>
Message-ID: <CAHQ1cqEFfBjzsPMBghi3jjthdUy=w7v2sEA33jiQ13caL39gaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 8:07 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Sep 11, 2018 at 05:10:43PM -0300, Fabio Estevam wrote:
> > imx51-zii-scu3-esb does not have any video encoding/decoding needs,
> > so disable the VPU.
>
> @Andrey, do you agree?
>

Oh, sorry, the though of providing an Acked-by didn't occur to me for
some reason, my apologies. Yeah, those boards definitely don't use
VPU.

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks,
Andrey Smirnov
