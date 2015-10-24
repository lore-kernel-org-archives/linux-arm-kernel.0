From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 24 Oct 2015 11:06:19 -0200
Subject: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt
 platform
In-Reply-To: <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
 <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
 <2333b5f060a8e45bd8adcdab55365fab@agner.ch>
 <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
Message-ID: <CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 7:21 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Stefan,
>
> On Tue, Oct 6, 2015 at 7:15 PM, Stefan Agner <stefan@agner.ch> wrote:
>> Hi Dong,
>>
>> Just hit that issue in 4.1, could we add that patch also to stable?
>
> I sent the series to stable, but Greg has not applied it yet.

Greg applied the series and it appears now in 4.1.11.
