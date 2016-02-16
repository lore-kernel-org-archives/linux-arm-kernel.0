From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 16 Feb 2016 02:23:46 +0100
Subject: [PATCH v6 2/2] ACPI: amba bus probing support
In-Reply-To: <1453300171-25473-3-git-send-email-aleksey.makarov@linaro.org>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
 <1453300171-25473-3-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1558867.xs6LSUHIo3@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 20, 2016 08:29:27 PM Aleksey Makarov wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> On ARM64 some devices use the AMBA device and not the platform bus for
> probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
> does not have a suitable clock representation and to keep the core
> AMBA bus code unchanged between probing methods.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

This one looks OK to me, so please just post an update of the [1/2].

Thanks,
Rafael
