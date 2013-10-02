From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 2 Oct 2013 18:39:42 -0500
Subject: [PATCH] ARM: dts: AM33XX: add ethernet alias's for am33xx
In-Reply-To: <1380736713-24678-1-git-send-email-dmurphy@ti.com>
References: <1380736713-24678-1-git-send-email-dmurphy@ti.com>
Message-ID: <524CAEBE.5010305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 October 2013 12:58 PM, Dan Murphy wrote:
> Set the alias for ethernet0 and ethernet1 so that uBoot
> can set the MAC address appropriately.
>
> Currently uBoot cannot find the alias and there for does not set the
> MAC address.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Tested this with beagle bone black.

Tested-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
