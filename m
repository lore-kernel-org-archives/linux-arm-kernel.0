From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 10:50:44 +0100
Subject: [PATCH 3/5] pinctrl: sirf: fix the pins of sdmmc5 connected with
 TriG
In-Reply-To: <1388717966-11703-4-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
 <1388717966-11703-4-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdaviWDmrpv2VrZLT7CqfzMPQXzx_s+5q-8ihPUe66Q2Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 3:59 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Bin Shi <Bin.Shi@csr.com>
>
> sdmmc5 has only 3 pins CMD, CLK, DATA which are connected with CSR
> TriG RF multi-GNSS. The hardware connection is like:
> DATA -- GPS_SGN
> CLK  -- GPS_RF_CLK
> CMD  -- GPS_MAG
> here we drop redundant pins in sdmmc5 group.
>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Patch applied.

Yours,
Linus Walleij
