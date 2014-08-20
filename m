From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Aug 2014 12:16:00 -0700
Subject: [PATCH v4] irqchip: gic: Allow gic_arch_extn hooks to call into
 scheduler
In-Reply-To: <20140818015430.GN12769@titan.lakedaemon.net>
References: <1407938238-21413-1-git-send-email-sboyd@codeaurora.org>
 <20140817173236.GG12769@titan.lakedaemon.net>
 <20140817185522.GX30401@n2100.arm.linux.org.uk>
 <20140817190434.GJ12769@titan.lakedaemon.net>
 <alpine.LFD.2.11.1408172000460.29347@knanqh.ubzr>
 <20140818012512.GL12769@titan.lakedaemon.net>
 <alpine.LFD.2.11.1408172131550.29347@knanqh.ubzr>
 <20140818015430.GN12769@titan.lakedaemon.net>
Message-ID: <53F4F3F0.20107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/14 18:54, Jason Cooper wrote:
>
> Stephen, is the out of tree code that triggered this bound for mainline?
>

It's bound for mainline eventually. We're actively working on enabling
more low power modes and when that happens we'll need this patch. We can
always carry this patch for now if you don't want to accept it, but I
figured getting it mainlined reduces our carrying burden and also makes
a minor improvement in sending IPIs when the BL switcher is used.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
