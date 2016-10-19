From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 18:55:37 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <20161019013612.GA107490@google.com>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com> <20160919231441.GA60928@google.com>
 <57E0E97B.5000106@arm.com> <20160928012309.GA29518@localhost>
 <20160929170847.1227a312@arm.com> <20161004174903.GA3098@localhost>
 <20161019012441.GW8871@codeaurora.org> <20161019013612.GA107490@google.com>
Message-ID: <86354ffe-9757-2a1f-92c9-9602fa08a057@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2016 06:36 PM, Brian Norris wrote:
> I believe we do not on either rk3288 or rk3399. We'd have to be powering
> off almost the entire system before we'd be able to gate the 24 MHz
> oscillator, AIUI.
>

Great! That avoids a major headache.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
