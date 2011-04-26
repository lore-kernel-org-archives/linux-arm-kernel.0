From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Apr 2011 09:21:59 -0700
Subject: [RFC PATCH 02/12] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <20110426100536.37b9b2ce@taxman.wild-wind.fr.eu.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>	<1303326501-15664-3-git-send-email-marc.zyngier@arm.com>	<4DB5A991.90002@codeaurora.org>
	<20110426100536.37b9b2ce@taxman.wild-wind.fr.eu.org>
Message-ID: <4DB6F127.8050605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2011 02:05 AM, Marc Zyngier wrote:
> I'd tend to agree with you, though local timer being the only user of
> PPIs, it doesn't matter that much... ;-)
>
>
>
> I'll move these changes to the first patch on the next iteration of the
> patch set.
>

Thanks. It mattered to me when I only pulled down the first patch and
the MSM patch and tested it out and was confused why the timer tick
wasn't happening. MSM doesn't have the ARM twd.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
