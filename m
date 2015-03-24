From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Mar 2015 13:37:41 +0200
Subject: [PATCH v7 0/6] wlcore: add device-tree support
In-Reply-To: <1426696710-6891-1-git-send-email-eliad@wizery.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
Message-ID: <55114C85.60703@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eliad,

On 03/18/2015 06:38 PM, Eliad Peller wrote:
> Add device-tree support to the wlcore (wl12xx/wl18xx)
> driver.
>
> Update the current users to use the bindings instead
> of pdata-quirks.
>
> Finally, remove the deprecated wl12xx_platform_data
> struct (along with the da850 board file code that
> still uses it)

Tested-by: Nikita Kiryanov <nikita@compulab.co.il>
Tested on am437x-gp-evm with WL1835MODCOM8B

-- 
Regards,
Nikita Kiryanov
