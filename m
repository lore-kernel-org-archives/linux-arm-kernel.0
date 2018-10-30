From: robh@kernel.org (Rob Herring)
Date: Tue, 30 Oct 2018 18:05:19 -0500
Subject: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel support
In-Reply-To: <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
 <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
Message-ID: <20181030230519.GA13247@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2018 17:09:30 +0200, Alex Gonzalez wrote:
> The change adds support for the AU Optronics G101EVN010 10.1" TFT LCD
> panel.
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  .../bindings/display/panel/auo,g101evn010          | 12 ++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g101evn010
> 

Reviewed-by: Rob Herring <robh@kernel.org>
