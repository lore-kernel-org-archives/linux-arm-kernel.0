From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Dec 2017 16:59:51 -0600
Subject: [PATCH v2 1/5] drm/panel: Add support for the EDT ETM0700G0BDH6
In-Reply-To: <20171220134710.64479-2-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171220134710.64479-1-jan.tuerk@emtrion.com>
 <20171220134710.64479-2-jan.tuerk@emtrion.com>
Message-ID: <20171221225951.npop3wxuouy6qxse@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 02:47:01PM +0100, jan.tuerk at emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
> 
> The Emerging Display Technology ETM0700G0BDH6 is exactly
> the same display as the ETM0700G0DH6, exept the pixelclock
> polarity. Therefore re-use the ETM0700G0DH6 modes. It is
> used by default on emtrion Avari based development kits.

As I asked on v1, why not document the panels together in a single doc?

> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  .../bindings/display/panel/edt,etm0700g0bdh6.txt          |  9 +++++++++
>  drivers/gpu/drm/panel/panel-simple.c                      | 15 +++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0bdh6.txt
