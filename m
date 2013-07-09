From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 11:03:48 -0600
Subject: [PATCH V2 10/11] ARM: dts: tegra114: dalmore: add GPIO power
 key support
In-Reply-To: <1372845047-25147-11-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
 <1372845047-25147-11-git-send-email-josephl@nvidia.com>
Message-ID: <51DC4274.8040607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2013 03:50 AM, Joseph Lo wrote:
> Adding the GPIO power key and enabling the wake up function.

I think I'll skip this one patch, because Laxman posted a more complete
patch "[PATCH V2] ARM: tegra: enable gpio-keys on dalmore". which
includes this change, plus defines another 3 keys.
