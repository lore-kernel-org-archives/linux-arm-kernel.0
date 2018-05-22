From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 21 May 2018 20:22:37 -0700
Subject: [PATCH 12/14] ARM: spectre-v2: KVM: invalidate icache on guest
 exit for Brahma B15
In-Reply-To: <E1fKjFj-00064b-62@rmk-PC.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjFj-00064b-62@rmk-PC.armlinux.org.uk>
Message-ID: <f6a2cbbd-0c76-cb8c-5394-df6d910474dd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/21/2018 04:45 AM, Russell King wrote:
> Include Brahma B15 in the Spectre v2 KVM workarounds.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
