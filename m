From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 06 Apr 2016 16:17:13 -0700
Subject: [PATCH 0/5] ARM: dts: rockchip: small cleanups
In-Reply-To: <1459457651-4727-1-git-send-email-heiko@sntech.de>
References: <1459457651-4727-1-git-send-email-heiko@sntech.de>
Message-ID: <2329989.BkuK88OEOr@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 22:54:06 schrieb Heiko Stuebner:
> Fix some missing unitnames on nodes having a reg property
> and drop unitnames on gpio-keys.
> 
> This explicitly leaves out the memory nodes, as it seems
> memory without unitname will keep being allowed, also
> to keep compatibility with bootloaders who may insert the
> actual amount of memory into those nodes. [0]

applied these with patch 2 fixed up to v2 for 4.7
