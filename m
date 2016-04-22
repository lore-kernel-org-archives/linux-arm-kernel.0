From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 22 Apr 2016 13:27:21 +0300
Subject: [PATCH 01/23] mmc: sdhci: removed unneeded function wrappers
In-Reply-To: <1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <5719FC89.9010404@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 20:29, Dong Aisheng wrote:
> After commit d6463f170cf0 ("mmc: sdhci: Remove redundant runtime PM calls"),
> some of original sdhci_do_xx() function wrappers becomes meaningless,
> so remove them.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Didn't apply cleanly, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
