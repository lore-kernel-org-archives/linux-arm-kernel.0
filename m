From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 12 Apr 2012 09:28:59 +0200
Subject: Booting DT support without U-Boot supporting it
In-Reply-To: <20120412051947.GG2445@S2101-09.ap.freescale.net>
References: <4F865817.3000802@st.com>
 <20120412051947.GG2445@S2101-09.ap.freescale.net>
Message-ID: <4F86843B.8080502@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.04.2012 07:19, Shawn Guo wrote:
> On Thu, Apr 12, 2012 at 09:50:39AM +0530, Viresh Kumar wrote:
>> Hi,
>>
>> My U-boot is on an older version and that doesn't have DT support for ARM.
>> Now, is there any way of booting Linux with DT, without U-Boot supporting DT?
>>
> This is how I responded to Fabio on the same query a few hours ago :)
> 
> - Turn on CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
> - cat zImage mx27pdk.dtb > zImage_dtb
> - Boot zImage_dtb as you do with zImage

Just fyi:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091371.html

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091457.html

Best regards

Dirk
