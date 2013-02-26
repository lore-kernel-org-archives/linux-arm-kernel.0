From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Feb 2013 10:02:22 +0000
Subject: [PATCH v2] arm: plat-samsung: check processor type before
 cache restoration in resume
In-Reply-To: <1361872613-12040-1-git-send-email-inderpal.singh@linaro.org>
References: <1361872613-12040-1-git-send-email-inderpal.singh@linaro.org>
Message-ID: <20130226100222.GQ17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 03:26:53PM +0530, Inderpal Singh wrote:
> Only cortex-a9 based samsung platforms have l2x0 cache controller. Hence check
> the same before restoring the cache in resume.

Why is this patch soo complicated?  Can't you read the CPUs MIDR register
from assembly code?
