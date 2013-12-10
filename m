From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 10 Dec 2013 11:34:45 -0800
Subject: [GIT PULL] at91: soc updates for 3.14 #1
In-Reply-To: <1386583059-22281-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Mon, 9 Dec 2013 10:57:39 +0100")
References: <1386583059-22281-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <87k3fc7b56.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> This pull-request is for addition of sama5d36 and its Evaluation Kit. The
> patches are stacked on the "cleanup" material already in arm-soc tree
> (at91/sama5-ccf) like all other AT91 pull-requests for 3.14.
>
> Thanks, best regards,
>
> The following changes since commit b46e837d8ef1f3c777bbf9513e2cdb5d87d6c374:
>
>   ARM: at91/dt: remove old clk material (2013-12-02 15:31:29 +0100)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-soc
>
> for you to fetch changes up to 0a72922b8dab2a1ce9cc977e9b1850556b48b4aa:
>
>   ARM: at91: sama5d3/dt: add sama5d36ek dts files (2013-12-09 09:50:53 +0100)
>
> ----------------------------------------------------------------
> First soc pull-request for 3.14
> Addition of the sama5d36 SoC as a member of the sama5d3 family
> - SoC code and Device Tree file
> - Evaluation Kit (EK board) Device Tree file
>
> ----------------------------------------------------------------
> Josh Wu (2):
>       ARM: at91: sama5d3: add support for sama5d36 chip

I cherry-picked this one into next/soc.

>       ARM: at91: sama5d3/dt: add sama5d36ek dts files

And this one into next/dt because it's just the DT data.  

Due to the dependencies on the cleanup branch (thanks for pointing them
out in the pull request!), the cleanup branch was also merged intot
next/dt.

Kevin
