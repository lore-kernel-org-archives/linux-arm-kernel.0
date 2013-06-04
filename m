From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 4 Jun 2013 10:14:00 +0530
Subject: [PATCH] clk: spear: fix build error for spear3xx
In-Reply-To: <2592841.P0ZcyhdZJA@wuerfel>
References: <2592841.P0ZcyhdZJA@wuerfel>
Message-ID: <CAOh2x=ne4k9fmVaDpnP-e_pmBdBMX4PY0FP0wg8cw1=3dd3GuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 3:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> This patch is required to be able to disable spear320 support
> after the spear320_clk_init() prototype changed for the real
> function but not for the dummy.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
