From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 17:05:08 -0700
Subject: [PATCH 1/2] ARM: DT: tegra: Add board level compatible properties
In-Reply-To: <1357170831-7836-1-git-send-email-pengw@nvidia.com>
References: <1357170831-7836-1-git-send-email-pengw@nvidia.com>
Message-ID: <50E4CB34.6070205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 04:53 PM, Bryan Wu wrote:
> The compatible properties of Tegra SoC based boards or machines need
> to be documented. This patch adds these board levle compatible
> properties into device tree binding document.

This series looks reasonable now. I'll apply it tomorrow.

It should be easy enough to add HDMI support; the driver is there.

Do you have any idea when SATA support could be added?
