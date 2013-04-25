From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:37:26 +0200
Subject: [PATCH 27/32] ARM: ux500: Stop registering DMA40 from platform
 data when DT is enabled
In-Reply-To: <1366279934-30761-28-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-28-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZiXb-sKW+WhWyFFvXwW1V+EEUhZFLHhZKYh5Utp1tWtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 12:12 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now the DMA40 has been DT:ed, there's no requirement to register it
> using traditional methods. This is the penultimate device to be DT:ed.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
