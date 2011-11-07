From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Nov 2011 14:01:00 +0000
Subject: [PATCH v3 04/17] ARM: mxc: convert smp platforms to global
 gic_handle_irq()
In-Reply-To: <20111104211540.GB3546@r65073-Latitude-D630>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
 <1320425871-30564-5-git-send-email-marc.zyngier@arm.com>
 <20111104211540.GB3546@r65073-Latitude-D630>
Message-ID: <4EB7E49C.6010608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/11 21:15, Shawn Guo wrote:
> On Fri, Nov 04, 2011 at 04:57:38PM +0000, Marc Zyngier wrote:
>> Convert the SMP shmobile platforms to use the global gic_handle_irq()
> 
> s/shmobile/imx
> 
> Other than the typo there, for patches #2 and #4:
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
>> function instead a private function.

Can't believe I made that many typo in so few patches... ;-)
Thanks for reviewing!

	M.
-- 
Jazz is not dead. It just smells funny...
