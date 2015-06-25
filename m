From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 25 Jun 2015 16:15:35 -0700
Subject: [PATCH 02/41] clocksource: cadence_ttc: Migrate to new
 'set-state' interface
In-Reply-To: <effe1fbb8239a26043a7e7bc5340f9ddd9aabd81.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <effe1fbb8239a26043a7e7bc5340f9ddd9aabd81.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <20150625231535.GU20178@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-18 at 04:24PM +0530, Viresh Kumar wrote:
> Migrate cadence_ttc driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
