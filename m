From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 22:52:06 +0000
Subject: [PATCH 6/9] drm/pci: move drm_pcie_get_speed_cap_mask inside
 #ifdef CONFIG_PCI
In-Reply-To: <CAOMZO5AbTC+82KKTqWXeseahsasx2q=q-4k9u14xyBYhgm2gdQ@mail.gmail.com>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-7-git-send-email-arnd@arndb.de>
 <CAOMZO5AbTC+82KKTqWXeseahsasx2q=q-4k9u14xyBYhgm2gdQ@mail.gmail.com>
Message-ID: <201302142252.06878.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 February 2013, Fabio Estevam wrote:
> Bjorn has already sent a fix for this problem:
> http://www.spinics.net/lists/arm-kernel/msg224425.html

Ok, excellent.

The result seems to be identical, although patch is formatted
differently.

Acked-by: Arnd Bergmann <arnd@arndb.de>

for Bjorn's patch.
