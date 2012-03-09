From: cjb@laptop.org (Chris Ball)
Date: Thu, 08 Mar 2012 23:35:21 -0500
Subject: [PATCH V2 1/1] mmc: start removing enable / disable API
In-Reply-To: <1330499841-6879-2-git-send-email-adrian.hunter@intel.com>
 (Adrian Hunter's message of "Wed, 29 Feb 2012 09:17:21 +0200")
References: <1330499841-6879-1-git-send-email-adrian.hunter@intel.com>
 <1330499841-6879-2-git-send-email-adrian.hunter@intel.com>
Message-ID: <m27gyuqtme.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian,

On Wed, Feb 29 2012, Adrian Hunter wrote:
> Most parts of the enable / disable API are no longer used and
> can be removed.
>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks very much, pushed to mmc-next for 3.4 (with Tested-by from
Venkatraman and Jaehoon).

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
