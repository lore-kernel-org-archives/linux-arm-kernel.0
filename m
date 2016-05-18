From: robh@kernel.org (Rob Herring)
Date: Wed, 18 May 2016 11:37:32 -0500
Subject: [PATCH v2 4/6] ir-rx51: add DT support to driver
In-Reply-To: <1463427254-7728-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1463427254-7728-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1463427254-7728-5-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <20160518163732.GA25142@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:34:12PM +0300, Ivaylo Dimitrov wrote:
> With the upcoming removal of legacy boot, lets add support to one of the
> last N900 drivers remaining without it. As the driver still uses omap
> dmtimer, add auxdata as well.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  .../devicetree/bindings/media/nokia,n900-ir          | 20 ++++++++++++++++++++
>  arch/arm/mach-omap2/pdata-quirks.c                   |  6 +-----
>  drivers/media/rc/ir-rx51.c                           | 11 ++++++++++-
>  3 files changed, 31 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir

Acked-by: Rob Herring <robh@kernel.org>
