From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 07 Feb 2012 19:07:04 +0100
Subject: [PATCH v3 24/25] irq_domain: remove "hint" when allocating irq
 numbers
In-Reply-To: <1327700179-17454-25-git-send-email-grant.likely@secretlab.ca>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-25-git-send-email-grant.likely@secretlab.ca>
Message-ID: <4F316848.4060100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2012 10:36 PM, Grant Likely :
> The 'hint' used to try and line up irq numbers with hw irq numbers is
> rather a hack and not very useful.  Now that /proc/interrupts also outputs
> the hwirq number, it is even less useful to keep around the 'hint' heuristic.
> 
> This patch removes it.

Grant,

While trying your patch series in conjunction with Rob one, I do not
find this patch in your irqdomain/next branch (and a couple of others).
Can you tell me if this v3 series is available as a git tree?

Thanks, best regards,
-- 
Nicolas Ferre
