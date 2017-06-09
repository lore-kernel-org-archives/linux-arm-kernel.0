From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 9 Jun 2017 17:53:39 -0500
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Jun 2017 14:15:01 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

Hi Mathieu,

> Please consider for inclusion in the 4.13 cycle.  Of particular interest is
> patch 15/17, which adds a new driver under the CoreSight umbrella.

After applying the patchseries, the devices now have self-named
subdirectories under them:

$ find /sys/devices/ -name \*sink\*
/sys/devices/platform/20140000.etf/20140000.etf/enable_sink
/sys/devices/platform/20070000.etr/20070000.etr/enable_sink
/sys/devices/platform/20030000.tpiu/20030000.tpiu/enable_sink
/sys/devices/platform/20010000.etf/20010000.etf/enable_sink
$ 

Which doesn't match the coresight.txt usage documentation...

Also, do the current juno platforms not have CPU debug modules?  I'd
like to test the new driver.

Thanks,

Kim
