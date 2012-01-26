From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jan 2012 19:11:34 +0000
Subject: [PATCH v1 3/3] ARM: tegra: cpuidle driver for tegra
In-Reply-To: <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
 <1327594923-21822-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120126191134.GA23484@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 06:22:03PM +0200, Peter De Schrijver wrote:
> CPUidle driver for tegra. In this version only LP3 (clockgating) is supported.

Are you aware of the work Rob Lee is doing on providing a common library
for the ARM generic bits of cpuidle?  I really must convert the s3c64xx
work I did on that over some time...
