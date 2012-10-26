From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 26 Oct 2012 15:55:32 +0530
Subject: [PATCH] davinci: fix the uart number in the comment
In-Reply-To: <1347559476-25363-1-git-send-email-henrique@henriquecamargo.com>
References: <1347559476-25363-1-git-send-email-henrique@henriquecamargo.com>
Message-ID: <508A651C.8090709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/13/2012 11:34 PM, Henrique Camargo wrote:
> The bit 0 of the field is uart0 and the bit 1 is uart1 and so on.
> 
> Signed-off-by: Henrique Camargo <henrique@henriquecamargo.com>

Queuing this for v3.8. Added an ARM: prefix to subject line since this
is an arch/arm/ patch. Please take care of this next time on.

Thanks,
Sekhar
