From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 11:44:34 -0700
Subject: [PATCH v3 5/6] misc: enable fuse drivers
In-Reply-To: <1390952176-30402-6-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-6-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52F28692.1070404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
> Enable building the fuse drivers.

This isn't really about enabling them. It's about changing which Tegra
fuse driver is built. Perhaps rephrase this more as:

ARM: tegra: build fuse driver from drivers/misc instead

The Tegra fuse code has moved to drivers/misc/fuse/tegra. Enable the
building of that code, and disable the building of the old fuse code in
arch/arm/mach-tegra/.
