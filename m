From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 05 Sep 2014 08:35:56 -0700
Subject: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Wed, 3 Sep 2014 12:52:16 +0200")
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7ha96eyt9f.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> This patchset has a bit of a history and some parts of it has been posted
> earlier.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
>
> The intent is to simplify code for the generic power domain and also some of
> the machine specific code that uses the generic power domain.
>
> Do note, there are dependencies through this patchset, especially related to
> the ARM SoC changes, thus they all need to be kept together.

Reviewed-by: Kevin Hilman <khilman@linaro.org>
