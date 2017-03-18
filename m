From: robh+dt@kernel.org (Rob Herring)
Date: Sat, 18 Mar 2017 15:38:40 -0500
Subject: [PATCH v5 3/5] dt-bindings: Add TI SCI PM Domains
In-Reply-To: <20170316182722.18486-1-d-gerlach@ti.com>
References: <1488882154-21485-4-git-send-email-d-gerlach@ti.com>
 <20170316182722.18486-1-d-gerlach@ti.com>
Message-ID: <CAL_JsqLUsp2nK-kX85OANVwfX15p1MyQS9Q03zsUqk-=hpYa6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 1:27 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow the TI SCI protocol to
> control device power states.
>
> Also, provide macros representing each device index as understood
> by TI SCI to be used in the device node power-domain references.
> These are identifiers for the K2G devices managed by the PMMC.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 57 ++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>  create mode 100644 include/dt-bindings/genpd/k2g.h

Acked-by: Rob Herring <robh@kernel.org>
