From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 19 Dec 2011 13:03:21 +0100
Subject: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
In-Reply-To: <1323439361-1647-4-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-4-git-send-email-b-cousson@ti.com>
Message-ID: <20111219120321.GM11800@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Fri, Dec 09, 2011 at 03:02:34PM +0100, Benoit Cousson wrote:
> Add initial device-tree support for twl familly chips.
> The current version is missing the regulator entries due
> to the lack of DT regulator bindings for the moment.
> Only the simple sub-modules that do not depend on
> platform_data information can be initialized properly.
> 
> Add documentation for the Texas Instruments TWL Integrated Chip.
Thanks, patch applied.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
