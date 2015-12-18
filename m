From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 18 Dec 2015 06:26:54 -0600
Subject: [PATCH] ARM: socfpga: Repair incorrectly applied MCV patch
In-Reply-To: <1450395498-9827-1-git-send-email-marex@denx.de>
References: <1450395498-9827-1-git-send-email-marex@denx.de>
Message-ID: <alpine.DEB.2.02.1512180623300.7406@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Dec 2015, Marek Vasut wrote:

> For whatever reason, this patch was not applied verbatim and had all
> tabs replaced with spaces. Replace them back by a quick sed.
> 

Thanks for catching this. I think what happened was that I had to pull this
patch from the mailing list, and whenever I forward a patch from my gmail
account, I can't seem to be able to use git am.

Anyways, patch is applied.

Thanks,
Dinh
