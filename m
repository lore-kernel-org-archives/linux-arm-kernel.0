From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Dec 2017 18:07:09 +0100
Subject: [GIT PULL 3/5] memory: tegra: Changes for v4.16-rc1
In-Reply-To: <20171220191900.757-3-thierry.reding@gmail.com>
References: <20171220191900.757-1-thierry.reding@gmail.com>
 <20171220191900.757-3-thierry.reding@gmail.com>
Message-ID: <CAK8P3a1aJSoty8DqKwpuy7-cFR3fAu3nHRvzrvqz3X5fMgbJZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 8:18 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> ----------------------------------------------------------------
> memory: tegra: Changes for v4.16-rc1
>
> The Tegra memory controller driver will now instruct the SMMU driver to
> create groups, which will make it easier for device drivers to share an
> IOMMU domain between multiple devices.
>
> Initial Tegra186 support is also added in a separate driver.

Pulled into next/drivers.

      Arnd
