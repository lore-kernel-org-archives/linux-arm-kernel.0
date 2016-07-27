From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 27 Jul 2016 12:12:58 -0700
Subject: [PATCH v2] ARM: dts: NSP: Correct RAM amount for BCM958625HR board
In-Reply-To: <1468527257-3339-1-git-send-email-jon.mason@broadcom.com>
References: <1468527257-3339-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <abb66d7e-7e58-e25a-10d0-40d0712f9508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2016 01:14 PM, Jon Mason wrote:
> The BCM958625HR board has 2GB of RAM available.  Increase the amount
> from 512MB to 2GB and add the device type to the memory entry.
> 
> Fixes: 9a4865d42fe5 ("ARM: dts: NSP: Specify RAM amount for BCM958625HR board")
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Applied, thanks!
-- 
Florian
