From: ak@linux.intel.com (Andi Kleen)
Date: Tue, 5 Dec 2017 09:27:48 -0800
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <1512490399-94107-3-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
Message-ID: <20171205172748.GI3070@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 12:13:16AM +0800, John Garry wrote:
> For some architectures (like arm64), there are architecture-
> defined recommended events. Vendors may not be obliged to
> follow the recommendation and may implement their own pmu
> event for a specific event cod

I would just duplicate the architected events into the different 
vendor files.  Then you wouldn't need all this mess.

-Andi
