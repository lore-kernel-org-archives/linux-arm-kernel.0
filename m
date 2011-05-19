From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 19 May 2011 14:14:17 +0300
Subject: [PATCH v6 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305637877-24436-2-git-send-email-marc.zyngier@arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
	<1305637877-24436-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305803657.2630.64.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-17 at 14:11 +0100, Marc Zyngier wrote:
> In the process of moving platforms away from integrator-flash
> (aka armflash), add to physmap the few features that make
> armflash unique:
> 
> - optionnal probing for the AFS partition type
> - init() and exit() methods, used by Integrator to control
>   write access to the various onboard programmable components
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Woodhouse <dwmw2@infradead.org>

Acked-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
