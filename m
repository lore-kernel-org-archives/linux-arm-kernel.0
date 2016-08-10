From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 15:17:07 -0500
Subject: [PATCH] dt: bindings: Remove focaltech,ft6236 binding
In-Reply-To: <1470677879-5907-1-git-send-email-hdegoede@redhat.com>
References: <1470677879-5907-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160810201707.GA23642@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 07:37:59PM +0200, Hans de Goede wrote:
> The focaltech ft6236 are i2c protocol compatible with other chips supported
> by the edt,ft5x06 driver. The duplicate ft6236 driver has already been
> removed from the kernel.
> 
> This commit removes the duplicate binding to match, adding its compatible
> string to the edt,ft5x06 binding.
> 
> This commit also adds the standard touchscreen properties as optional
> properties to the edt,ft5x06 binding, these were documented in the
> focaltech,ft6236 binding but missing from the edt,ft5x06 doc.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  8 +++++
>  .../input/touchscreen/focaltech-ft6236.txt         | 35 ----------------------
>  2 files changed, 8 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt

The subject is a bit misleading, but:

Acked-by: Rob Herring <robh@kernel.org>
