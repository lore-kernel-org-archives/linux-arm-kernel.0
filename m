From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Dec 2017 15:44:29 +0100
Subject: [PATCH 4/6] arm: dts: nspire: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <20171109222614.5719-4-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-4-robh@kernel.org>
Message-ID: <CAK8P3a3mYm6f0Z9Yis2YjikidikqPTV8w1qLsSrR6=onrVhD8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 9, 2017 at 11:26 PM, Rob Herring <robh@kernel.org> wrote:
> "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
> property. This is probably because the binding was the precursor to the phy
> binding.
>
> Fixes the following warning in nspire dts files:
>
> Warning (phys_property): Missing property '#phy-cells' in node ...
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Doesn't seem to be a maintainer for nspire. Arnd, please apply.

Applied to fixes, thanks!

       Arnd
