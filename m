From: jani.nikula@linux.intel.com (Jani Nikula)
Date: Tue, 20 Nov 2018 11:53:43 +0200
Subject: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
In-Reply-To: <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
 <1542363310.23489.22.camel@pengutronix.de>
 <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
Message-ID: <87lg5of520.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018, Fernando <greenfoo@gluegarage.com> wrote:
> And, related to this, what is the "good" branch to start developing
> new drm patches? Is is "drm-next" or "linux-next"? Or does it change
> depending on how much time until the merge window closes?

I advise most of our developers to work on drm-tip because it contains
the latest stuff in drm core, i915, amd, most of the small drivers, as
well as sound. It's a bit like "linux-next for graphics". And you don't
really have to care about the merge cycles with that.

But YMMV, it probably doesn't work for everyone.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
