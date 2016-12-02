From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 2 Dec 2016 11:30:00 +0530
Subject: [PATCH v2] arm64: dts: zx: support cpu-freq for zx296718
In-Reply-To: <CA+DQWkzGOzn1TRa9041Jjksj-=509XWXS_U1uaaJXNydB8Apow@mail.gmail.com>
References: <1480657956-8140-1-git-send-email-baoyou.xie@linaro.org>
 <CA+DQWkzGOzn1TRa9041Jjksj-=509XWXS_U1uaaJXNydB8Apow@mail.gmail.com>
Message-ID: <20161202060000.GE7682@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-12-16, 13:58, Baoyou Xie wrote:
> + Viresh, the author of the bindings.
> 
> On 2 December 2016 at 13:52, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> 
> > This patch adds the CPU clock phandle in CPU's node
> > and uses operating-points-v2 to register operating points.
> >
> > So it can be used by cpufreq-dt driver.
> >
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > ---
> >  arch/arm64/boot/dts/zte/zx296718.dtsi | 39 ++++++++++++++++++++++++++++++
> > +++++
> >  1 file changed, 39 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
