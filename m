From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 18 Sep 2013 09:28:44 -0600
Subject: [PATCH REPOST] ARM: tegra: use dt-binding header for key code
In-Reply-To: <1379510552-23401-1-git-send-email-ldewangan@nvidia.com>
References: <1379510552-23401-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <5239C6AC.10403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 07:22 AM, Laxman Dewangan wrote:
> In place of hardcoding the key code in DTS file and comment the
> key code as side notes, use the key code macro defines in the
> dt-bindings/input/input.h directly.

I can apply this, but aren't there many other Tegra DT files that need
conversion too?
