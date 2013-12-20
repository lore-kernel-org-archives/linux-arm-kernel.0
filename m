From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Dec 2013 10:56:52 -0700
Subject: [PATCH 07/10] ARM: tegra: Enable Venice2 keyboard
In-Reply-To: <1387469182-14398-8-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-8-git-send-email-treding@nvidia.com>
Message-ID: <52B484E4.8050509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 09:06 AM, Thierry Reding wrote:
> The keyboard on Venice2 is attached to the ChromeOS embedded controller.
> Add the corresponding device tree nodes and use the MATRIX_KEY define to
> encode keycodes.

Patches 7/10 and 8/10 do work fine with the current pinmux/regulator
setup in Tegra's for-3.14/dt, so I have applied those patches.
