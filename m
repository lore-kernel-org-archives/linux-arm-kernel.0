From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Wed, 1 Jun 2011 16:31:54 +0200
Subject: [PATCH 2/3] clocksource: add DB8500 PRCMU Timer support
In-Reply-To: <20110601142507.GK3660@n2100.arm.linux.org.uk>
References: <1306830661-9546-1-git-send-email-mattias.wallin@stericsson.com>
	<alpine.LFD.2.02.1105311236250.3078@ionos>
	<4DE51EB7.7010606@stericsson.com>
	<BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
	<4DE5F0DB.2050409@stericsson.com> <4DE64B0E.8030008@stericsson.com>
	<20110601142507.GK3660@n2100.arm.linux.org.uk>
Message-ID: <4DE64D5A.20206@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2011 04:25 PM, Russell King - ARM Linux wrote:
> sched_clock is supposed to be setup and initialized really early.  Why
> are you doing trying to move it soo late?
Linus idea was to remove the dependency from mach-ux500/cpu.c where I 
originally called the init function by using core_initcall.

Should I use pure_initcall or solve it some other way?
