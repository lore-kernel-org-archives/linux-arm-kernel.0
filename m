From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Dec 2010 16:57:17 -0800
Subject: [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire
	during suspend
In-Reply-To: <87zksfc53b.fsf@deeprootsystems.com>
References: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
	<AANLkTi=9TBbuwr4uiQb6f_f=cLxK2NvWJDJYXwr2tTxu@mail.gmail.com>
	<87zksfc53b.fsf@deeprootsystems.com>
Message-ID: <20101210005717.GP3054@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [101209 07:40]:
> Vitaly Wool <vitalywool@gmail.com> writes:
> >>
> >> +static void omap2_pm_end(void)
> >> +{
> >> + ? ? ? suspend_state = PM_SUSPEND_ON;
> >> + ? ? ? return;
> >> +}
> >
> > Redundant return.
> 
> but harmless

I'll queue this fix, will leave out the harmless return.

Regards,

Tony
