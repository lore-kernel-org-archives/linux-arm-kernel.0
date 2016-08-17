From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 17 Aug 2016 09:24:38 -0700
Subject: [PATCH 0/1] ARM: Keystone: Fix USB on v4.8-rc
In-Reply-To: <1471430690-17143-1-git-send-email-rogerq@ti.com>
References: <1471430690-17143-1-git-send-email-rogerq@ti.com>
Message-ID: <cb2b85fe-4cd9-7905-0cea-9c0b7315cba0@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/17/2016 3:44 AM, Roger Quadros wrote:
> Hi Santosh,
>
> USB ports are broken on Keystone2 boards since v4.8-rc1.
> This is because CONFIG_KEYSTONE_USB_PHY is no longer being enabled
> by keystone_defconfig. Fix that.
>
> Please pick this for the v4.8-rc cycle. Thanks.

Have requested arm-soc folks to pick it up. Thanks for
the fix.
