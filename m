From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 23:29:49 +0200
Subject: [PATCH 1/2] arm: dts: fix unit-address leading 0s
In-Reply-To: <20171013175452.1198-1-robh@kernel.org>
References: <20171013175452.1198-1-robh@kernel.org>
Message-ID: <CAK8P3a0GHWkG-xXHMMrBLMvjGPyk2_bK56s6uLmjzNMjo4nC6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 7:54 PM, Rob Herring <robh@kernel.org> wrote:
> Fix dtc warnings for 'simple_bus_reg' due to leading 0s. Converted using
> the following command:
>
> perl -p -i -e 's/\@0+([0-9a-f])/\@$1/g' `find arch/arm/boot/dts -type -f -name '*.dts*'
>
> Dropped changes to ARM, Ltd. boards LED nodes and manually fixed up some
> occurrences of uppercase hex.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied both to next/dt, thanks a lot for the cleanups!

        Arnd
