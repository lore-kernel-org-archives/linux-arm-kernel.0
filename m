From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 26 Jul 2016 15:08:49 -0700
Subject: [PATCH 00/14] PM: SoC idle support using PM domains
In-Reply-To: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Wed, 22 Jun 2016 13:36:35 -0600")
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <m260rsuk5q.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Hi all,
>
> Changes since RFC-v3:
> - Reorganize the patches. Documentations have their own patch.
> - Moved code around with PSCI OS initiated so they would not have compiler
>   errors in other configuration.
> - Minor bug fixes with genpd power_on functionality.
> - Rebased on top of 4.7-rc1

This is looking good.  I've had a quick look through this, as well as
tested it on apq8016-sbc (dragon 410c.)

Seems the main thing left to resolve is the DT description.

Kevin
