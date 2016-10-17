From: adrian.hunter@intel.com (Adrian Hunter)
Date: Mon, 17 Oct 2016 09:36:33 +0300
Subject: [PATCH 2/2] mmc: sdhci-iproc: support standard byte register
 accesses
In-Reply-To: <1476297352-7812-3-git-send-email-scott.branden@broadcom.com>
References: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
 <1476297352-7812-3-git-send-email-scott.branden@broadcom.com>
Message-ID: <7505a7f0-a781-8677-047d-7598def231e8@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/16 21:35, Scott Branden wrote:
> Add bytewise register accesses support for newer versions of IPROC
> SDHCI controllers.
> Previous sdhci-iproc versions of SDIO controllers
> (such as Raspberry Pi and Cygnus) only allowed for 32-bit register
> accesses.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
