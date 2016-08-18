From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Aug 2016 14:27:40 -0500
Subject: [PATCH v2] dt-bindings: touchscreen: silead gsl1680: Document
 all compatibles
In-Reply-To: <1471424340-4201-1-git-send-email-hdegoede@redhat.com>
References: <1471424340-4201-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160818192740.GA1325@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 10:59:00AM +0200, Hans de Goede wrote:
> The silead gsl1680 driver / binding supports a whole series of devices,
> list the compatibles for all of them in the binding.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Drop the "silead,mssl1680" compatible thing, the "mssl1680" name is an
>  ACPI thing and does not belong in the dt bindings
> ---
>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt          | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
