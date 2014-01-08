From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 10:52:05 +0100
Subject: [PATCH 5/5] ARM: dts: SiRF: add pin group for USP0 with only RX
 or TX frame sync
In-Reply-To: <1388717966-11703-6-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
 <1388717966-11703-6-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdbEa3ODUWj7FcObdUbVZmmSng2xCjK-WoQzj+g28_Sd_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 3:59 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Rongjun Ying <Rongjun.Ying@csr.com>
>
> add pin groups for USP0 only holding one of TX and RX frame sync. this
> patch matches with the change in drivers/pinctrl/sirf.
>
> Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
> Signed-off-by: Barry Song <Barry.Song@csr.com>

Please carry this patch through ARM SoC or similar Sirf tree.

Yours,
Linus Walleij
