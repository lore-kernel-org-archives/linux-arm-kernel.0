From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 15 Feb 2016 18:38:18 +0000
Subject: [PATCH 2/2] hwmon: (scpi) add energy meter support
In-Reply-To: <1455028377-12728-2-git-send-email-sudeep.holla@arm.com> (Sudeep
 Holla's message of "Tue, 9 Feb 2016 14:32:57 +0000")
References: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
 <1455028377-12728-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <8760xpakf9.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> SCPI specification v1.1 adds support for energy sensors. This patch
> adds support for the same.
>
> Cc: Punit Agrawal <punit.agrawal@arm.com>

  Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/hwmon/scpi-hwmon.c    | 8 ++++++++
>  include/linux/scpi_protocol.h | 1 +
>  2 files changed, 9 insertions(+)
>

[...]
