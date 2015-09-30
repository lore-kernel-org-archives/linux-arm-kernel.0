From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 13:18:03 +0300
Subject: [RFC PATCH 00/20] Coresight integration with perf
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87k2r8jjms.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> This patchset aims to integrate configuration and control of
> the Coresight tracers with the perf sub-system.
>
> The goal is to use PMUs to represent tracers and the auxiliary
> buffer enhancement to collect processor traces.  As such a lot
> of work is done to move the current Coresight sysFS oriented
> configuration and control commands to perf's AUX API.

Another general question: is there anything that prevents a sysfs user
from changing ETM/ETB configuration while it's used by a perf event? I
couldn't find any code in this patchset that would implement such
exclusivity.

Thanks,
--
Alex
