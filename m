From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 25 Apr 2016 19:00:59 +0530
Subject: [PATCH v2 3/4] ARM: davinci: disable mdio and eth0 in da850.dtsi
In-Reply-To: <1460826020-1256-4-git-send-email-david@lechnology.com>
References: <1460826020-1256-1-git-send-email-david@lechnology.com>
 <1460826020-1256-4-git-send-email-david@lechnology.com>
Message-ID: <571E1C13.9050204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Saturday 16 April 2016 10:30 PM, David Lechner wrote:
> All other devices are disabled by default and not all boards will use
> these devices, so these should be disabled too..
> 
> da850-evm.dtb already had status = "okay" for these devices.
> da850-enbw-cmc.dts did not, so they were added.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

I applied this and other patches in this series. One nit-pick though.
The commit description should be independently readable and not only as
continuation of the headline. Even if this means repeating portion of
the headline. I fixed this for most of the patches in this series. For
example, for this patch, I have:

    ARM: dts: da850: disable mdio and eth0 in da850.dtsi

    Disable mdio and eth0 in da850.dtsi file. All other
    devices are disabled by default and not all boards
    will use these devices, so these should be disabled too.

    da850-evm.dtb already had status = "okay" for these devices.
    da850-enbw-cmc.dts did not, so they were added.

    Signed-off-by: David Lechner <david@lechnology.com>
    Tested-by: Kevin Hilman <khilman@baylibre.com>
    [nsekhar at ti.com: commit description updates]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Its a minor change and I wont reply to all the patches with the changes
I made. But I pushed the updated v4.7/dt branch in my tree. Do take a
look at the commit description there.

Thanks,
Sekhar
