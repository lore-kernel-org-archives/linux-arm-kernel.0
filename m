From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Apr 2014 17:16:45 -0600
Subject: [PATCH v2 3/3] ARM: tegra: fix Venice2 SD card VQMMC supply
In-Reply-To: <1397689719-28882-4-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-4-git-send-email-abrestic@chromium.org>
Message-ID: <534F0F5D.3030904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 05:08 PM, Andrew Bresticker wrote:
> VDDIO_SDMMC3 is the VQMMC (I/O) supply, not the VMMC (core) supply,
> for the SD slot on Venice2.

I've applied this (one patch) to Tegra's for-3.16/dt branch.
