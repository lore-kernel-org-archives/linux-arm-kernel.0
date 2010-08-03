From: a.paterniani@swapp-eng.it (Andrea Paterniani)
Date: Tue, 03 Aug 2010 15:10:43 +0200
Subject: USB re-enumeration after kexec
Message-ID: <4C581553.9060706@swapp-eng.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
In my application (based on OMAP3530) I need to load and execute a new 
kernel zImage using kexec.
I have several devices connected to host USB (thru HUB) and I need to 
re-enumerate after kexec without phisycal disconnect and reconnect.
Is there any way to do this action by SW?

Regards,
Andrea
