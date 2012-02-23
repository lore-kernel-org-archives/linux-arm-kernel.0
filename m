From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 23 Feb 2012 16:22:09 +0100
Subject: [PATCH 3/7] MFD: twl-core: regulator configuration for twl6030
 V1V8, V2V1 SMPS
In-Reply-To: <1328868316-24749-4-git-send-email-peter.ujfalusi@ti.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868316-24749-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120223152209.GA24377@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Feb 10, 2012 at 12:05:12PM +0200, Peter Ujfalusi wrote:
> To be able to attach consumers to these supplies from board
> files we need to have regulator_init_data for them.
If I understand correctly, this should also go through Liam's tree. If that's
so, please add my:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
