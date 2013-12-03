From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 13:09:18 -0700
Subject: [PATCH 2/2] ARM: tegra: convert device tree file of Dalmore to
 use pinctrl defines
In-Reply-To: <1385992502-12771-2-git-send-email-ldewangan@nvidia.com>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
 <1385992502-12771-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <529E3A6E.1050003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 06:55 AM, Laxman Dewangan wrote:
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Patch description?

BTW, did you compile all the Tegra DT files before and after this
change, and make sure that there's zero difference between them (i.e.
they're identical byte-for-byte when compiled)? I don't feel like
manually double-checking this entire patch...
