From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 11:45:48 -0700
Subject: [PATCH 1/2] arm64: dts: NS2: Add all of the UARTs
In-Reply-To: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
References: <1463007369-13071-1-git-send-email-jonmason@broadcom.com>
Message-ID: <573F5B5C.7080407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2016 03:56 PM, Jon Mason wrote:
> Add all of the UARTs present on NS2 and enable them in the SVK device
> tree file.  Also, do some magic to make sure that uart3 is discovered as
> ttyS0 (as that is the console UART).
> 
> Signed-off-by: Jon Mason <jonmason@broadcom.com>

Applied to devicetree-arm64/next, thanks Jon!
-- 
Florian
