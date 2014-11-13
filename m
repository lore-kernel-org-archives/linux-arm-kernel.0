From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 09:12:39 +0100
Subject: [PATCH 5/5] ARM: mvebu: enable i2c device in mvebu_v7_defconfig
In-Reply-To: <1415835600-97188-6-git-send-email-mw@semihalf.com>
References: <1415835600-97188-1-git-send-email-mw@semihalf.com>
 <1415835600-97188-6-git-send-email-mw@semihalf.com>
Message-ID: <20141113091239.671bc152@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 13 Nov 2014 00:40:00 +0100, Marcin Wojtas wrote:
> This commit enables user-space access to I2C bus using char device.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Even though not directly tied to HW capabilities, having userspace
access to I2C devices is quite useful in development-related defconfigs.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
