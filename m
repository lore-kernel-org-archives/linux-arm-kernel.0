From: Nitin.Saxena@caviumnetworks.com (Saxena, Nitin)
Date: Tue, 3 May 2016 18:42:31 +0000
Subject: VFIO MSIX Query
Message-ID: <3517EB80-0AE6-4F54-AC0B-C1D0DC01158C@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am a newbie to VFIO framework and trying to use it for MSIX interrupt handling in my userspace application. My userspace application is like intel's dpdk.

My query is why vfio kernel code does not support msix masking/ unmasking i.e VFIO_SET_ACTION_TRIGGER is not implemented in kernel vfio code for MSIX but its present for legacy INTX?

Another question since MSIX interrupt masking is absent in kernel who is supposed to mask/unmask msix interrupt? does userspace needs to mask/unmask interrupt after getting notified by eventfd. Is there any usecase where MSIX handling is done via VFIO framework?

Thanks,
Nitin 


Regards,
Nitin
