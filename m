From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 17 Aug 2017 15:04:47 +0300
Subject: [PATCH v2 1/2] usb: dwc3: keystone: Add PM_RUNTIME Support to
 DWC3 Keystone USB driver
In-Reply-To: <20170816215408.13076-2-fcooper@ti.com>
References: <20170816215408.13076-1-fcooper@ti.com>
 <20170816215408.13076-2-fcooper@ti.com>
Message-ID: <87r2waqu1s.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Franklin S Cooper Jr <fcooper@ti.com> writes:
> For 66AK2Gx there is a requirement to use PM Runtime to properly manage
> clocks and the power domains. Therefore, add PM runtime support. Remove
> legacy clock api's calls since other users of this driver worked without
> these clock apis calls.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---

I already have the previous version of this in my tree. Seems like the
only difference was on binding document, right? Do I need to change
anything in my 'next' and/or 'testing/next' branches?

-- 
balbi
