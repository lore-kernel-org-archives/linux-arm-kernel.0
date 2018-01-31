From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 30 Jan 2018 16:32:37 -0800
Subject: [PATCH v2] ARM64: dts: meson s905x: accept MAC addr from u-boot
 environment
In-Reply-To: <1516186543-22056-1-git-send-email-jramirez@baylibre.com> (Jorge
 Ramirez-Ortiz's message of "Wed, 17 Jan 2018 11:55:43 +0100")
References: <1516186543-22056-1-git-send-email-jramirez@baylibre.com>
Message-ID: <7hinbic1ga.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jorge Ramirez-Ortiz <jramirez@baylibre.com> writes:

> With the adequate configuration settings, u-boot will loop through the
> list of aliases looking for "ethernetX".
>
> By adding an ethernet alias, u-boot can fixup the local-mac-address
> property in the kernel's device tree using a value held in its
> environment variable ethaddr.
>
> Tested-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>

Applied to v4.17/dt64,

Kevin
