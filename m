From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:29:24 -0700
Subject: [PATCH v2] ARM: dts: berlin: Add missing OPP properties for CPUs
In-Reply-To: <20180720181150.15a2aa71@xhacker.debian>
References: <20180720130838.187becb9@xhacker.debian>
 <20180720181150.15a2aa71@xhacker.debian>
Message-ID: <20180721212924.sduyl4dcmz7mzbvz@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 06:11:50PM +0800, Jisheng Zhang wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> 
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
> 
> Add such missing properties.
> 
> Fix other missing properties (clocks, clock latency) as well to
> make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> Since v1:
>  - fix author, it's from Viresh. Sorry for making this mistake

Applied, thanks.


-Olof
