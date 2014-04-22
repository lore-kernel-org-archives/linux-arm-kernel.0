From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 15:44:02 +0200
Subject: [PATCH 15/20] mfd: db8500-prcmu: Use cpufreq_for_each_entry macro
 for iteration
In-Reply-To: <534C4EB8.9080704@semaphore.gr>
References: <534C4EB8.9080704@semaphore.gr>
Message-ID: <CACRpkdZjcgC-9mgS7ZQDKOxPhCf720d2usdB+KzxqEMPcjSfiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 11:10 PM, Stratos Karafotis
<stratosk@semaphore.gr> wrote:

> The cpufreq core supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
>
> It should have no functional changes.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
