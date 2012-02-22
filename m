From: sr@denx.de (Stefan Roese)
Date: Wed, 22 Feb 2012 11:31:04 +0100
Subject: [PATCH v2] arm/spear600: fix one-shot timer
In-Reply-To: <1329905892-10085-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <4F446F4B.3030008@st.com>
 <1329905892-10085-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <201202221131.04577.sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012 11:18:12 Gilles Chanteperdrix wrote:
> Currently, the "clockevent_next_event" function only works correctly
> if the timer is not running when this function is called, which is
> not always the case when running with CONFIG_HIGH_RES_TIMERS.
> 
> Fix this by stopping the timer at the beginning of this function.
> 
> Acked-by: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Acked-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
