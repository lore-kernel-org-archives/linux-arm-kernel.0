From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 15 Nov 2011 02:16:10 +0100
Subject: [PATCH 04/41] ARM: restart: at91: use new restart hook
In-Reply-To: <E1RN6ic-0001Wp-7t@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ic-0001Wp-7t@rmk-PC.arm.linux.org.uk>
Message-ID: <20111115011610.GF15318@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:41 Sun 06 Nov     , Russell King - ARM Linux wrote:
> Rather than using a private function pointer, use the existing
> arm_pm_restart function pointer instead.  We no longer need to enable
> the I-cache in at91sam9_alt_reset() as the caches will now be on when
> this function is called.
> 
> Update the function names to use the 'restart' terminology rather than
> the 'reboot' terminology.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
I'll appply this one via at91-treee as I've patch that touch this part too in
the queue if you do'nt mind

Best Regsards,
J.
