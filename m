From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 30 Jan 2018 16:33:28 -0800
Subject: [PATCH] ARM64: dts: meson: accept MAC addr from u-boot environment
In-Reply-To: <1516186587-22157-1-git-send-email-jramirez@baylibre.com> (Jorge
 Ramirez-Ortiz's message of "Wed, 17 Jan 2018 11:56:27 +0100")
References: <1516186587-22157-1-git-send-email-jramirez@baylibre.com>
Message-ID: <7hd11qc1ev.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jorge Ramirez-Ortiz <jramirez@baylibre.com> writes:

> Extend configuring the MAC address from u-boot to all meson boards.
>
> I didn't test this changeset but having checked libretech's u-boot
> tree I believe it should just work.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>

Applied for v4.17, let's see we find any breakage in linux-next,

Kevin
