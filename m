From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 13:19:49 +0800
Subject: Booting DT support without U-Boot supporting it
In-Reply-To: <4F865817.3000802@st.com>
References: <4F865817.3000802@st.com>
Message-ID: <20120412051947.GG2445@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 09:50:39AM +0530, Viresh Kumar wrote:
> Hi,
> 
> My U-boot is on an older version and that doesn't have DT support for ARM.
> Now, is there any way of booting Linux with DT, without U-Boot supporting DT?
> 
This is how I responded to Fabio on the same query a few hours ago :)

- Turn on CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
- cat zImage mx27pdk.dtb > zImage_dtb
- Boot zImage_dtb as you do with zImage

Regards,
Shawn
