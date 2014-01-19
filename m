From: ananaza@iki.fi (Antti Miettinen)
Date: Sun, 19 Jan 2014 07:20:31 +0200
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52D932B5.7020909@nvidia.com> (Prashant Gaikwad's message of
 "Fri, 17 Jan 2014 19:10:05 +0530")
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
 <20140115154526.GC3571@mudshark.cambridge.arm.com>
 <52D76BC8.6080405@nvidia.com>
 <20140116121649.GG30257@mudshark.cambridge.arm.com>
 <878uufyo13.fsf@iki.fi> <52D8F403.9070602@linaro.org>
 <52D901B6.1070800@nvidia.com> <52D902D6.3090208@linaro.org>
 <52D915F3.3030500@nvidia.com> <52D91D3A.80800@linaro.org>
 <52D932B5.7020909@nvidia.com>
Message-ID: <87zjmsy2cg.fsf@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prashant Gaikwad <pgaikwad@nvidia.com> writes:
> For some idle states it may be required to change the timer when
> entering idle state to adjust the exit latency.

Would it work to set up a separate software timer to account for the
exit latency?

	--Antti
