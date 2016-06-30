From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 30 Jun 2016 15:34:05 +0900
Subject: [PATCH v3] arm: tegra124: remove commas from unit addresses
In-Reply-To: <1467238897-10028-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1467238897-10028-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <03546b91-7c7d-427a-a583-827f00eda64c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 30, 2016 7:21:37 AM JST, Marcel Ziswiler wrote:
> Remove commas from unit addresses as suggested by Rob Herring upon me
> posting initial Apalis TK1 support:
>
> http://article.gmane.org/gmane.linux.ports.tegra/26608
>
> Please keep the remaining 0, notation on the GPU node in place as a
> former mainline U-Boot version was looking for that particular notation
> in order to perform required fix-ups on it.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Confirmed that GPU still probes and is usable after this.
