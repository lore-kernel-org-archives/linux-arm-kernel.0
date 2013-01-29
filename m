From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 09:50:28 -0800
Subject: [GIT PULL] imx6q cpuidle for 3.9
In-Reply-To: <20130129054635.GA21504@S2101-09.ap.freescale.net>
References: <20130129054635.GA21504@S2101-09.ap.freescale.net>
Message-ID: <20130129175028.GC17935@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 01:46:37PM +0800, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx6q-cpudile-3.9
> 
> for you to fetch changes up to e510aafde64a3fdd741f598e4d2be3c079bf5b0e:
> 
>   ARM: imx6q: support WAIT mode using cpuidle (2013-01-29 13:41:42 +0800)
> 
> ----------------------------------------------------------------
> It's imx6q cpuidle series for 3.9.
> 
> ----------------------------------------------------------------
> Shawn Guo (4):
>       ARM: imx: return zero in case next event gets a large increment
>       ARM: imx: mask gpc interrupts initially
>       ARM: imx: move imx6q_cpuidle_driver into a separate file
>       ARM: imx6q: support WAIT mode using cpuidle

This has some small conflicts with the cleanup branch. Can you please base it
on top of cleanup so we can avoid the merge conflicts when things go upstream?
It's common to have the per-soc cleanup branches as bases for some of the
feature branches just for this reason.


Thanks!

-Olof
