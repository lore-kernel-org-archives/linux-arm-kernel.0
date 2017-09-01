From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 1 Sep 2017 15:18:03 +0200
Subject: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
In-Reply-To: <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
Message-ID: <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2017 at 15:50, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:
>
>> This patch should be merged along with the 1st patch of the series "mmc: host:
>> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
>> omap_hsmmc driver.
>
> I can sign a tag if it's needed for a cross tree merge.

Easier if you could drop it and instead just provide an ack.

Unless you believes there may conflict in your regulator tree?

Kind regards
Uffe
