From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 21:17:35 -0600
Subject: [PATCH v2 25/26] drm/panel: simple: Add timings for the Olimex
 LCD-OLinuXino-4.3TS
In-Reply-To: <1452785109-6172-26-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-26-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160115031735.GA26011@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 04:25:08PM +0100, Maxime Ripard wrote:
> Add support for the Olimex LCD-OLinuXino-4.3TS panel to the DRM simple
> panel driver.
> 
> It is a 480x272 panel connected through a 24-bits RGB interface.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../display/panel/olimex,lcd-olinuxino-43-ts.txt   |  7 ++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt
