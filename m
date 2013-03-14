From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Thu, 14 Mar 2013 02:11:47 +0200
Subject: [PATCH RESEND 0/1] omap4: control: Add the CONTROL_SMART2IO_PADCONF_2
 register definition
Message-ID: <1363219908-32007-1-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello guys,

This is a resend of my quite old patch
( https://patchwork.kernel.org/patch/1130991/ ) that
was submitted 9 months ago but I suddenly found that
it is still not picked up in the mainline.
It will be needed for OMAP USB Host HW errata (i687)
implementation that will be sent in a separate patch later

Regards,
Ruslan

Ruslan Bilovol (1):
  omap4: control: Add the CONTROL_SMART2IO_PADCONF_2 register
    definition

 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h |   45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

-- 
1.7.9.5
