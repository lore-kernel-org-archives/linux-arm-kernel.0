From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 13 Jan 2013 16:03:24 -0200
Subject: Build error on kernel/rcutree.c
Message-ID: <CAOMZO5ASEY6iHQ1UekR88vWZPutsJdiEuGkpsC2Civ6ezi2NGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

When building ARM imx_v4_v5_defconfig the following error shows up on
linux-next 20130111:

kernel/rcutree.c:808:2: error: implicit declaration of function
'rcu_jiffies_till_stall_check' [-Werror=implicit-function-declaration]
kernel/rcutree.c:941:6: error: 'rcu_cpu_stall_suppress' undeclared
(first use in this function)

Is this a known issue?

Regards,

Fabio Estevam
