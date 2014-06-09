From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 09 Jun 2014 12:33:50 -0600
Subject: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
In-Reply-To: <53915F3B.6050806@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <5390A8F9.2090408@wwwdotorg.org> <53915F3B.6050806@nvidia.com>
Message-ID: <5395FE0E.80105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 12:27 AM, Mikko Perttunen wrote:
> The only compile-time dependencies here should be that:
> - patch 8 of 9 which contains the actual driver depends on patch 6 of 9
> (though only when building as a module) and the efuse series

> - patch 2 of 9 refers to the DT node called "padctl", so it requires the
> xusb series. (in the submitted xusb series, the node isn't actually
> named, though. I will fix this in v2)

Isn't that dependency a run-time dependency?
