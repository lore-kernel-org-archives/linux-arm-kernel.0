From: khilman@ti.com (Kevin Hilman)
Date: Wed, 15 Feb 2012 11:35:03 -0800
Subject: [PATCHv2 7/8] arm: omap: clockdomain: add support for preventing
 domain transitions
In-Reply-To: <1329320274-481-8-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Wed, 15 Feb 2012 17:37:53 +0200")
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
 <1329320274-481-8-git-send-email-t-kristo@ti.com>
Message-ID: <87vcn799g8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Some clockdomains can't support manual domain transitions triggered by
> clock framework, and must be prevented from doing so. Added clkdm flag
> CLKDM_NO_MANUAL_TRANS for doing this.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

Dumb Q: what's the difference between this new flag and CLKDM_CAN_SWSUP?

Kevin
