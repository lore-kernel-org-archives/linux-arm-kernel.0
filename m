From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2016 22:40:08 +0100
Subject: [GIT PULL] STi defconfig fix for v4.9-rcs
In-Reply-To: <0492803d-d136-618d-bf06-51f0001d039b@st.com>
References: <0492803d-d136-618d-bf06-51f0001d039b@st.com>
Message-ID: <6441620.Ib6HJmGOKY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 23, 2016 9:59:14 AM CET Patrice Chotard wrote:
> STi defconfig fix:
> 
> Enable HVA (Hardware Video Accelerator) video encoder
> driver for STMicroelectronics SoC.

Defconfig changes like this don't seem particularly urgent. Unless
there is a good reason, I'd suggest putting this into v4.10 instead.

	Arnd
