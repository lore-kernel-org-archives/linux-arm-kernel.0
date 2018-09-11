From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2018 15:36:51 +0200
Subject: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
 <CA+sq2CdNRkbGrk4rHOQX1qHrRc2+=DXBscw7cD9UKrX4G5OaVg@mail.gmail.com>
Message-ID: <CAK8P3a32gpNX42NuzmbW1PbsHpq7v7LoQ6WDeKtt=QiYbuyM7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 2:37 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> Didn't receive any feedback for the v3 patch series over a week's time.
> Can you please pick up these patches to merge into arm-soc ?

I would still prefer to see the whole thing as part of drivers/net/
instead of drivers/soc,
and reviewed in full on the netdev side, including the parts that are
not ethernet specific.

       Arnd
