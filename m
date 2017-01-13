From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 12 Jan 2017 16:07:46 -0800
Subject: [PATCH] ARM: dts: NSP: Fix DT ranges error
In-Reply-To: <1484236210-16067-1-git-send-email-jon.mason@broadcom.com>
References: <1484236210-16067-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <88ba8fb2-071c-73cb-d26a-b5b2dbdd0f4f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2017 07:50 AM, Jon Mason wrote:
> The range size for axi is 0x2 bytes too small, as the QSPI needs
> 0x11c408 + 0x004 (which is 0x0011c40c, not 0x0011c40a).  No errors have
> been observed with this shortcoming, but fixing it for correctness.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Applied to devicetree/fixes thanks Jon.
-- 
Florian
