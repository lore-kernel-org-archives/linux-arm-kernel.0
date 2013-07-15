From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 12:27:36 -0600
Subject: [PATCH] ARM: tegra114: Enable Cortex-A15 errata 798181
In-Reply-To: <1372845348-27089-1-git-send-email-josephl@nvidia.com>
References: <1372845348-27089-1-git-send-email-josephl@nvidia.com>
Message-ID: <51E43F18.4090508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2013 03:55 AM, Joseph Lo wrote:
> The commit 93dc688 (ARM: 7684/1: errata: Workaround for Cortex-A15
> erratum 798181 (TLBI/DSB operations)) introduecd a workaround for
> Cortex-A15 errata 798181. Enabling it for Tegra114.

Applied to Tegra's for-3.12/soc branch.
