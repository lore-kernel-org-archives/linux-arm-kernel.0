From: sophian.yoma@gmail.com (yoma sophian)
Date: Mon, 5 Sep 2016 14:36:18 +0800
Subject: about kernel configuration CONFIG_CPU_ARM_CORTEX_A15
Message-ID: <CADUS3omWW=cKszst9KJ-kD4vNNv0BrawPeEnhLuMvES34SBQNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
if we run cortex-a53 in aarch32 mode, shall we enable
"CONFIG_CPU_ARM_CORTEX_A15" this compile option when generating kernel
image?

>From below gcc path
https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/arm/cortex-a15.md;h=ccab7cbe90621459ad7356074d1543be59d5d929;hb=gcc-4_7-branch
, the  "CONFIG_CPU_ARM_CORTEX_A15" seems used to optimize cotex a15
code flow based on its pipeline architecture.
if pipeline architecture is the only consideration for enable
"CONFIG_CPU_ARM_CORTEX_A15" and if cortex a53 in aarch32 mode has the
same pipeline architecture as cortex a15, does that mean we could
enable "CONFIG_CPU_ARM_CORTEX_A15" ?

Meanwhile, how about other armv8-a processor, such as cortex a57, a72, etc.?
shall we enable "CONFIG_CPU_ARM_CORTEX_A15" for them when running
kernel in aarch32 mode?

appreciate your kind help in advance,
