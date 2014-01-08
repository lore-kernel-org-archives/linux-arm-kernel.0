From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 10:49:52 +0100
Subject: [PATCH 2/5] ARM: dts: SiRF: add lost usp1_uart_nostreamctrl pin
 group for atlas6
In-Reply-To: <1388717966-11703-3-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
 <1388717966-11703-3-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdbiPzB-MJr7Dm24b3cNd9urcT3SSV9qAz2iRPfCjygAHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 3:59 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Qipan Li <Qipan.Li@csr.com>
>
> this patch adds lost usp1_uart_nostreamctrl pin group for atlas6, which
> matches with the change in drivers/pinctrl/sirf/pinctrl-atlas6.c.
>
> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Please funnel this patch through ARM SoC or similar sirf tree.

Yours,
Linus Walleij
