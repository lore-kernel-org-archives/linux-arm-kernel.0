From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 19 Feb 2014 19:02:54 +0100
Subject: [PATCH 06/17] spi: pl022: Let runtime PM callbacks be available
 for CONFIG_PM
In-Reply-To: <20140219151040.GH2669@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-7-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFombL2-Rt46QpXPNWe5PeGQnOGmQQNfYd5MdYdEePn-4w@mail.gmail.com>
 <20140219151040.GH2669@sirena.org.uk>
Message-ID: <CAPDyKFqvdm73s9wDPA=z7LkiMmtLhGkcpwEdbS13zGHE5spQNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2014 16:10, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 19, 2014 at 03:20:07PM +0100, Ulf Hansson wrote:
>
>> Also note that, Russell has already applied the corresponding part in
>> the amba bus (patch 1)
>
> Why would this depend on an AMBA patch and if it does surely the two
> need to be merged together somehow?

There are no immediate dependency, sorry for confusion.

I just wanted to highlight that the amba has converted to the new
SET_PM_RUNTIME_PM_OPS. It means the amba bus' runtime PM callbacks are
available for CONFIG_PM.

Kind regards
Uffe
