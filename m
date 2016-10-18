From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 18 Oct 2016 10:55:20 +0300
Subject: ARM: AMx3xx/DRA7: crypto IP support data
Message-ID: <1476777327-700-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series finalizes the crypto support for amx3xx / dra7 socs,
adding the hwmod data and fixing one issue with l4sec clockdomain
on dra7.

Branch against 4.9-rc1 available here:
tree: https://github.com/t-kristo/linux-pm.git
branch: 4.9-rc1-crypto-data

-Tero
