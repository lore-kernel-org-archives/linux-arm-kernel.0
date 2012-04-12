From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Apr 2012 11:37:27 +0000
Subject: Booting DT support without U-Boot supporting it
In-Reply-To: <4F865817.3000802@st.com>
References: <4F865817.3000802@st.com>
Message-ID: <201204121137.27191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 April 2012, Viresh Kumar wrote:
> My U-boot is on an older version and that doesn't have DT support for ARM.
> Now, is there any way of booting Linux with DT, without U-Boot supporting DT?
> 
> Like, if we can compile dtb somehow with Linux or something else?

Yes, see CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT.

	Arnd
