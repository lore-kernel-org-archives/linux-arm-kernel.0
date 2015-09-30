From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 30 Sep 2015 12:01:20 +0300
Subject: [RFC PATCH 00/20] Coresight integration with perf
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87wpv8jn6n.fsf@ashishki-desk.ger.corp.intel.com>
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
>
> For the time being the work concentrates on ETMv3 and ETB1.0
> sink buffers.  Work on ETMv4 and other type of sink buffers
> will follow once a foundation has been established.

Also this patchset doesn't seem to apply to tip/perf/core, v4.3-rc3,
v4.2. What is it based on? Do you have a git branch with these patches
as well?

Regards,
--
Alex
