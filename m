From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 17 Oct 2013 15:32:36 -0700
Subject: [GIT PULL] Highbank updates for 3.13
In-Reply-To: <5260334D.30009@gmail.com> (Rob Herring's message of "Thu, 17 Oct
 2013 13:58:21 -0500")
References: <5260334D.30009@gmail.com>
Message-ID: <87k3hbzfy3.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robherring2@gmail.com> writes:

> Kevin, Olof,
>
> Please pull. Doing merge with arm-soc/for-next, there's a trivial merge
> conflict with highbank.c includes.
>
> Rob
>
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> tags/highbank-for-3.13
>
> for you to fetch changes up to 78bbca1a54bd05f7c7d38a306073a3ee7f866e51:
>
>   dts: calxeda: add ARM PSCI binding (2013-10-01 16:34:17 -0500)
>
> ----------------------------------------------------------------
> Highbank platform updates for 3.13
>
> - convert Calxeda cpuidle driver to a platform driver and to use PSCI
> - convert highbank smp_ops and suspend to PSCI
>
> ----------------------------------------------------------------

Pulled into next/soc.

Thanks,

Kevin
