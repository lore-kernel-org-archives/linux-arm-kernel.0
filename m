From: rodrigo@tjader.xyz (=?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?=)
Date: Wed, 26 Sep 2018 12:14:15 -0300
Subject: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix
 ethernet
In-Reply-To: <20180926094525.e4fepvonmy7ykdbb@flea>
References: <20180919141938.18791-1-rodrigo@tjader.xyz>
 <20180921142941.5ymp7ksphgboxrwz@flea>
 <CAG7TQgFOuHHmkm-6CDDYJ6KuDqfjNvFjnt8_9BPYfdP=oV57VQ@mail.gmail.com>
 <20180926094525.e4fepvonmy7ykdbb@flea>
Message-ID: <CAG7TQgFEqH6k0GAPA3yqKDQbtA=n9Qiw0-rq-aNNVZ5L6+Unhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 6:46 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> There's no need to be so specific though :)
>
> Something like that would work:
>
> arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay
>
> The PHY found on the A64-Olinuxino requires a TX delay in order to
> operate properly. Olimex uses a 600ps second delay in their BSP, and
> that has been found to work, so let's use that value in the current
> DT.

Should I go ahead and send a v2 with that commit message then?
