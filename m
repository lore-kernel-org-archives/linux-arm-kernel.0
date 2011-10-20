From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 20 Oct 2011 14:58:50 +0530
Subject: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
	for debug_prints
In-Reply-To: <CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
	<1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
	<CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
	<CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930328693C85@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Govindraj,

On Thu, Oct 20, 2011 at 14:09:22, Govindraj wrote:
> Yes correct, I missed that part here is the updated patch [1]
> Updated change-log for debug/loglevel and checked console_loglevel
> in addition to debug in bootargs.

Perhaps checking console_loglevel only is sufficient, if I am not
missing anything, passing "debug" thr' bootargs only causes loglevel
to be set to 10 and nothing else.

Regards
Afzal
