From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 08 Oct 2016 09:12:49 -0700
Subject: [PATCH v2] ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes
In-Reply-To: <1475564803-9616-1-git-send-email-brian.kim@hardkernel.com>
 (Brian Kim's message of "Tue, 4 Oct 2016 16:06:43 +0900")
References: <1475564803-9616-1-git-send-email-brian.kim@hardkernel.com>
Message-ID: <7hbmyues5a.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Kim <brian.kim@hardkernel.com> writes:

> Enable both gxbb USB controller and add a 5V regulator for the OTG port
> VBUS
>
> Signed-off-by: Brian Kim <brian.kim@hardkernel.com>
> ---
> This patch was written on Kevin Hilman's repository[1] and branch[2]:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git
> [2] v4.8/integ

Applied to the v4.10/dt64 branch, and will be included shortly in the
integration branch.

Kevin
