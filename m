From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Sat, 07 Mar 2015 14:27:35 +0200
Subject: [PATCH 4/5] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <1425078294-13059-5-git-send-email-mathieu.poirier@linaro.org>
References: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
 <1425078294-13059-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87ioed6lhk.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> From: Pratik Patel <pratikp@codeaurora.org>
>
> This driver adds support for the STM CoreSight IP block,
> allowing any system compoment (HW or SW) to log and
> aggregate messages via a single entity.
>
> The STM exposes an application defined number of channels
> called stimulus port.  Configuration is done using entries
> in sysfs and channels made available to userspace via devfs.

I somehow missed it when it was posted, but anyway. It looks like we are
solving a very similar problem (the STM device) and I'd like to propose
a generic and architecture independent solution [1]. I also took the
liberty to copy you and Pratik on those patches.

[1] https://lkml.org/lkml/2015/3/7/99

Regards,
--
Alex
