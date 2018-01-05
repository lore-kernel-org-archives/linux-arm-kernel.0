From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 17:53:05 +0100
Subject: [GIT PULL 2/5] i.MX SoC updates for 4.16
In-Reply-To: <1514959040-9992-2-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
 <1514959040-9992-2-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a3a=pUDuG===fQoWtwpUf-E2aOgoSpUenWxii+pvBKYuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 6:57 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> ----------------------------------------------------------------
> i.MX SoC updates for 4.16:
>  - Drop power saving status checking from MMDC driver probe function,
>    since there is nothing really depending on power saving being
>    enabled.
>  - Clean up unused imx3 pm definitions.

Pulled into next/soc, thanks!

       Arnd
