From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Feb 2014 11:25:41 +0100
Subject: [PATCH 00/17] amba: PM fixups for amba bus and some amba drivers
In-Reply-To: <20140204184909.GT22609@sirena.org.uk>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <20140204184909.GT22609@sirena.org.uk>
Message-ID: <CAPDyKFq+p5x+XFSRNJN6qVOCNhACU=JSs3rtH+0peVmpdYkZ3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 February 2014 19:49, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 04, 2014 at 04:58:41PM +0100, Ulf Hansson wrote:
>
>> The fixes for the amba bus needs to be merged prior to the other, thus I think
>> it could make sense to merge this complete patchset through Russell's tree,
>> if he and the other maintainers think this is okay.
>
> What are the actual dependencies for the SPI bit?  AFAICT it's probably
> the first patch needs the bus updating?

Correct!

At this point I thought it made sense to collect all this patches,
since it adopts to use the new SET_PM_RUNTIME_PM_OPS macro from the PM
core.

In principle I wanted to visualize in one go how driver's system
suspend|resume callbacks could be implemented for three similar
scenarios.

Kind regards
Ulf Hansson
