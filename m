From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:24:35 -0700
Subject: [PATCH] arm64: defconfig: Enable some IPMI configs
In-Reply-To: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
References: <1539879427-11816-1-git-send-email-john.garry@huawei.com>
Message-ID: <20181102182435.x46hvfgegxprksxq@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Fri, Oct 19, 2018 at 12:17:07AM +0800, John Garry wrote:
> The arm64 port now runs on servers which use IPMI. This patch enables
> relevant core configs to save manually enabling them when testing
> mainline.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

I don't think these are required for booting to rootfs, so I'm applying
the patch but switching them over to modules (=m) instead. Hope that's
sufficient for your testing, let me know if it isn't.


Thanks,

-Olof
