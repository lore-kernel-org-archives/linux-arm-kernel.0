From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Apr 2018 11:31:17 -0700
Subject: [PATCH] arm64: dts: correct SATA addresses for Stingray
In-Reply-To: <1524040889-6876-1-git-send-email-srinath.mannam@broadcom.com>
References: <1524040889-6876-1-git-send-email-srinath.mannam@broadcom.com>
Message-ID: <20180418183117.14237-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2018 14:11:29 +0530, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> Correct all SATA ahci and phy controller register
> addresses and interrupt lines to proper values.
> 
> Fixes: 344a2e514182 ("arm64: dts: Add SATA DT nodes for Stingray SoC")
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Andrew Gospodarek <andrew.gospodarek@broadcom.com>
> ---

Applied to devicetree-arm64/fixes, thanks!
--
Florian
