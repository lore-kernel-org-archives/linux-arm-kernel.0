From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Jan 2013 13:48:14 +0530
Subject: [PATCH 4/5] ata: arasan: remove the need for platform_data
In-Reply-To: <1359410300-26113-5-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-5-git-send-email-arnd@arndb.de>
Message-ID: <CAKohponH5jU_iiSmzJyhP22EwZ=RFFHKCrPYk7AagiVw1RREuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2013 03:28, Arnd Bergmann <arnd@arndb.de> wrote:
> This adds a complete DT binding for the arasan device driver. There is
> currently only one user, which is the spear13xx platform, so we don't
> actually have to parse all the properties until another user comes in,
> but this does use the generic DMA binding to find the DMA channel.
>
> The patch is untested so far and is part of a series to convert
> the spear platform over to use the generic DMA binding, so it
> should stay with the rest of the series.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
