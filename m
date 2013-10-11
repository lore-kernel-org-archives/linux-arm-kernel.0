From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Fri, 11 Oct 2013 10:54:01 +0200
Subject: Arm errata 752520
Message-ID: <20131011105401.443ccdc1@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

tegra kernel on android tree have a workaround for cortex A9 errata
752520 :
"ARM: errata: 752520: Faulty arbitration between PLD and Cacheable TLB
requests may create a system deadlock."
https://android.googlesource.com/kernel/tegra/+/eabc12e1afe0bfc2f9e6f7bacae03985439df1a2%5E!/#F1


But this errata is not in mainline kernel. Do you know why ?
Should a patch be submitted to add it ?



Regards,

Matthieu


PS : There is also another patch for errata 720791.
