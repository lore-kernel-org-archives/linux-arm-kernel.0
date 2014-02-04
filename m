From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Feb 2014 21:50:24 +0100
Subject: [PATCH 2/2] ARM: dts: sirf: add pin group for USP0 with only RX
 or TX frame sync for atlas6
In-Reply-To: <1391061293-2195-1-git-send-email-21cnbao@gmail.com>
References: <1391061293-2195-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdboFk7TvJ6MqwYOWRJcAqqXx+jJVitUYq2grwnCHwS5hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 6:54 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Rongjun Ying <rongjun.ying@csr.com>
>
> add pin groups for USP0 only holding one of TX and RX frame sync. this patch
> matches with the change in drivers/pinctrl/sirf.
>
> commit 73f68c01f46 did this for prima2, but missed prima2. this patch fixes
> the problem.
>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please take this patch through the ARM SoC tree.

Yours,
Linus Walleij
