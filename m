From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 5 Oct 2011 10:53:23 -0600
Subject: [PULL] Devicetree for 3.2
In-Reply-To: <4E8C88A1.4090308@gmail.com>
References: <4E8C88A1.4090308@gmail.com>
Message-ID: <CACxGe6siwgLK0PA3Xtfkzyz4opf-ox4Vid0PQY7EUQMw_3DtMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2011 at 10:41 AM, Rob Herring <robherring2@gmail.com> wrote:
> Grant,
>
> Please pull for 3.2. These commits don't have any dependencies and are
> not dependencies for me, so they don't need to go in thru arm-soc.
>
> Rob
>
> The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:
>
> ?Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)
>
> are available in the git repository at:
> ?git://git.jdl.com/software/linux-3.0.git for-grant
>
> Rob Herring (4):
> ? ? ?MAINTAINERS: update devicetree maintainers
> ? ? ?of/irq: of_irq_find_parent: check for parent equal to child
> ? ? ?devicetree: Add ARM pl061 gpio controller binding doc
> ? ? ?devicetree: Add ARM pl022 spi controller binding doc

Pulled thanks.

Nit: the of_irq_find_parent patch really should have my acked-by, and
I had hoped to get Ben's too.  (though I did only say "looks good"
without explicitly write an a-b in my reply, so did leave ambiguity).
We *might* end up having to revert that one if it causes problems in
powerpc-land.

g.

>
> ?.../devicetree/bindings/gpio/pl061-gpio.txt ? ? ? ?| ? 10 ++++++++++
> ?.../devicetree/bindings/spi/spi_pl022.txt ? ? ? ? ?| ? 12 ++++++++++++
> ?MAINTAINERS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 ++
> ?drivers/of/irq.c ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 14 +++++++-------
> ?4 files changed, 31 insertions(+), 7 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/gpio/pl061-gpio.txt
> ?create mode 100644 Documentation/devicetree/bindings/spi/spi_pl022.txt
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
