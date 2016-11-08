From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 8 Nov 2016 11:55:07 +0200
Subject: [PATCH v2 2/2] mmc: sdhci-iproc: support standard byte register
 accesses
In-Reply-To: <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
 <1478018277-10097-3-git-send-email-scott.branden@broadcom.com>
Message-ID: <c94dc018-5a2d-d50b-5746-43ae7fc258ce@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/16 18:37, Scott Branden wrote:
> Add bytewise register accesses support for newer versions of IPROC
> SDHCI controllers.
> Previous sdhci-iproc versions of SDIO controllers
> (such as Raspberry Pi and Cygnus) only allowed for 32-bit register
> accesses.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

This is unchanged from V1 which I acked, so:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
