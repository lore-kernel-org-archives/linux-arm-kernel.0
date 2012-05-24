From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2012 16:31:08 +0200
Subject: [PATCH] pinctrl: sirf: mark of_device_id match table as
 __devinitconst
In-Reply-To: <1337569142-18756-1-git-send-email-Barry.Song@csr.com>
References: <1337569142-18756-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdaJoM182X9LFRrORk8twYaAm_UUcACg+hs90e6MJSMEqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 4:59 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
> ?drivers/pinctrl/pinctrl-sirf.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks. I will be sending the first batch of fixes including this after
v3.5-rc1 is out.

Yours,
Linus Walleij
