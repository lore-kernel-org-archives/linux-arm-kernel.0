From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Oct 2018 17:19:28 +0200
Subject: [GIT PULL] ti-sysc driver changes for omaps for v4.20
In-Reply-To: <pull-1538588866-709117@atomide.com>
References: <pull-1538588866-709117@atomide.com>
Message-ID: <CAK8P3a2uKxvd5ujeemoNNuOTo_zgYth8g-PDPBfapg_1eT7_tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2018 at 7:48 PM Tony Lindgren <tony@atomide.com> wrote:
> TI sysc driver changes for v4.20 merge window
>
> This series gets rid of the SYSC_QUIRK_RESOURCE_PROVIDER to make device
> detection happen mostly only if #define DEBUG is set. Few core devices still
> need to be detected to set legacy quirks.
>
> We also add support for booting am335x, am437x and dra7 SoCs with L4 devices
> defined in device tree instead of legacy platform data.
>
> And finally we simplify suspend with just SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> and dropping the custom functions that were attempting to work around
> issues that really turned out to be child device driver related issues.

Pulled into next/drivers, thanks!

> Apologies for a late pull request, debugging the suspend issues took a while
> and I did not want to send these changes until that got sorted out.

No worries.

     Arnd
