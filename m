From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 22 May 2014 13:19:06 -0700
Subject: [PATCH v4 0/2] context tracker support for arm64
In-Reply-To: <1400786855-32656-1-git-send-email-larry.bassel@linaro.org>
 (Larry Bassel's message of "Thu, 22 May 2014 12:27:33 -0700")
References: <1400786855-32656-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <7h7g5dlg79.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Larry Bassel <larry.bassel@linaro.org> writes:

> Implement and enable context tracking for arm64 (which is
> a prerequisite for FULL_NOHZ support). This patchset
> builds upon earlier work by Kevin Hilman and is based on
> Will Deacon's tree.

Tested-by: Kevin Hilman <khilman@linaro.org>

Test this with NO_HZ_FULL on v3.15-rc5 merged with the aarch64 branch
from Will's tree on the foundation model (with the DT modified so the
arch timer doesn't enter C3_STOP mode.)

Kevin
