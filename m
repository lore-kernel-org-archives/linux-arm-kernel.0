From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Nov 2018 12:40:06 +0100
Subject: [PATCH v6 5/9] dt-bindings: ARM: document marvell,
 ecc-enable binding
In-Reply-To: <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
Message-ID: <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2018 at 8:04 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> properties which can be used to enable/disable ECC on the Marvell aurora
> cache.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Why do you need both enable and disable? Wouldn't one of them be enough here?

      Arnd
