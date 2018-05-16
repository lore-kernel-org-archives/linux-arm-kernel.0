From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 May 2018 09:27:22 -0700
Subject: [PATCH 12/14] ARM: spectre-v2: KVM: invalidate icache on guest
 exit for Brahma B15
In-Reply-To: <E1fIuBe-0003qZ-PD@rmk-PC.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuBe-0003qZ-PD@rmk-PC.armlinux.org.uk>
Message-ID: <8abf6598-0ce7-47b2-a801-d1e417865c6b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2018 04:01 AM, Russell King wrote:
> Include Brahma B15 in the Spectre v2 KVM workarounds.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
