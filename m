From: robh@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 16:18:20 -0500
Subject: [RESEND PATCH 1/2] drm/panel: Add support for Armadeus ST0700
 Adapt
In-Reply-To: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
References: <20181024125457.25204-1-sebastien.szymanski@armadeus.com>
Message-ID: <20181025211820.GA1173@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Oct 2018 14:54:56 +0200, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= wrote:
> This patch adds support for the Armadeus ST0700 Adapt. It comes with a
> Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
> that it can be connected on the TFT header of Armadeus Dev boards.
> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
