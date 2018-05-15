From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 15 May 2018 08:59:02 +0200
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
Message-ID: <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> This patch is provided in the context of allowing the Coresight driver
> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> to bus_find_device() in of_coresight_get_endpoint_device() when
> searching for a configurable endpoint device.  This patch allows
> Coresight to reference amba_bustype when built as a module.

Sounds like you are fixing a bug, don't your want this to go for
stable and then also add a fixes tag?

>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
