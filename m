From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 13 Jan 2017 12:03:59 -0800
Subject: [PATCH v4] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
In-Reply-To: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 11 Jan 2017 11:10:14 +0100")
References: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m21sw66828.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Amlogic Meson GXBB/GXL/GXM secure monitor uses part of the memory space,
> this patch adds this reserved zone and redefines the usable memory range.
>
> The memory node is also moved from the dtsi files into the proper dts files
> to handle variants memory sizes.
>
> This patch also fixes the memory sizes for the following platforms :
> - gxl-s905x-p212 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
> - gxm-s912-q201 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
> - gxl-s905d-p231 : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
> - gxl-nexbox-a95x : 1GiB instead of 2GiB, a proper 2GiB dts should be pushed
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v4.10-rc.

Kevin
