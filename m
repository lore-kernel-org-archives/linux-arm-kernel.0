From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 18 Nov 2016 16:45:49 +0200
Subject: [PATCH V8 2/3] stm class: ftrace: Add ftrace-export-over-stm
 driver
In-Reply-To: <1479438454-28650-3-git-send-email-zhang.chunyan@linaro.org>
References: <1479438454-28650-1-git-send-email-zhang.chunyan@linaro.org>
 <1479438454-28650-3-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <87y40getia.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> This patch adds a driver that models itself as an stm_source called
> stm_ftrace. Once the stm device and stm_ftrace have been linked via
> sysfs, the driver registers itself as a trace_export and everything
> passed to the interface from Ftrace subsystem will end up in the STM
> trace engine.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex
