From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 15 Feb 2016 18:36:04 +0000
Subject: [PATCH 1/2] firmware: arm_scpi: add support for 64-bit sensor
 values
In-Reply-To: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com> (Sudeep
 Holla's message of "Tue, 9 Feb 2016 14:32:56 +0000")
References: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <87a8n1akiz.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> SCPI specification version 1.1 extended the sensor from 32-bit to 64-bit
> values in order to accommodate new sensor class with 64-bit requirements
>
> Since the SCPI driver sets the higher 32-bit for older protocol version
> to zeros, there's no need to explicitly check the SCPI protocol version
> and the backward compatibility is maintainted.
>
> Cc: Punit Agrawal <punit.agrawal@arm.com>

Thanks for the update to the driver.

       Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scpi.c   | 8 +++++---
>  drivers/hwmon/scpi-hwmon.c    | 6 +++---
>  include/linux/scpi_protocol.h | 2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
>
> Hi Guenter,
>
> Since I have couple of other fixes for SCPI driver, if you can provide
> your ACKs to this couple of patches after your review, I can take all of
> them together via ARM-SoC if that's fine with you.
>
> Regards,
> Sudeep
>

[...]
