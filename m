From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Oct 2015 10:19:20 +1100
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20151015101920.7fa592f7@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arch/arm/boot/dts/berlin2q.dtsi:62.24-25 syntax error
FATAL ERROR: Unable to parse input tree

I can't see what caused this error, so I have just used the arm-soc tree
from next-20151013 for today.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
