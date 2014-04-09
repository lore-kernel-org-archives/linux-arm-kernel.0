From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 9 Apr 2014 12:26:47 +0530
Subject: [PATCH] ARM: dts: am335x-boards: Fixup the usb control module
 address in respective Board files
In-Reply-To: <1396962477-9045-1-git-send-email-george.cherian@ti.com>
References: <1396962477-9045-1-git-send-email-george.cherian@ti.com>
Message-ID: <5344EF2F.8010106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 April 2014 06:37 PM, George Cherian wrote:
> The USB Contol Module address was updated in am33xx.dtsi file
> by the following commit 8abcdd680d543fb582371e146e62ba9f2af8a816
> ARM: dts: am33xx: correcting dt node unit address for usb
>
> The same changes need to be done for respective board files.
> Without these changes USB wont be detected in any of the boards.
>
> Signed-off-by: George Cherian <george.cherian@ti.com>

Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
