From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 15:46:33 -0800
Subject: [GIT PULL] at91: cleanup for 3.14 #2
In-Reply-To: <1389190989-8261-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Wed, 8 Jan 2014 15:23:09 +0100")
References: <1389190989-8261-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <877ga25dpi.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Arnd, Olof, Kevin,
>
> A little "cleanup" pull-request for 3.14 that goes on top of the previous
> AT91 cleanup material.
> The thing to note from this pull-request is the beginning of board file removal
> thank to the conversion to DT. We are still waiting for more feedback from
> board maintainer to intensify the effort.
>
> Thanks, best regards,
>
> The following changes since commit b46e837d8ef1f3c777bbf9513e2cdb5d87d6c374:
>
>   ARM: at91/dt: remove old clk material (2013-12-02 15:31:29 +0100)
>
> are available in the git repository at:
>
>   git://github.com/at91linux/linux-at91.git tags/at91-cleanup2
>
> for you to fetch changes up to e91a5555df5883bbc204b0e1f8e0489d3f7f3f2e:
>
>   ARM: at91: switch Calao QIL-A9260 board to DT (2013-12-19 17:27:30 +0100)
>
> ----------------------------------------------------------------
> Second cleanup pull-request for 3.14:
> - a tiny fix for the recent AT91 CCF implementation
> - the switch of one platform to DT with board file removal
>
> ----------------------------------------------------------------

Pulled into next/cleanup.

Thanks,

Kevin
