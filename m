From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Apr 2012 02:49:28 -0600 (MDT)
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204260246170.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vaibhav,

looking at Table 1-1 "Device Features" of SPRUH73D, it seems that some 
AM33xx family chips come with some features disabled, such as the 
PRU-ICSS, the SGX, Ethernet, or USB.  How will this affect the clock tree?  
For example, is it correct for us to include the PRU-ICSS clock control on 
a clock tree that is booted on an AM3352 or an AM3354?


- Paul
