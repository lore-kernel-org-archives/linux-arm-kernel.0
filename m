From: bhaskarbudiredla@gmail.com (Bhaskara rao Budiredla)
Date: Mon, 11 May 2015 20:47:21 +0530
Subject: Physical memory start address for ARM cores
Message-ID: <CAJWVF-whTD0Nm-cup-qOt-M-PYn-6GojSiE9pS2Db0R35D5aUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Could you please confirm if ARM architecture mandates the physical
memory start address to align with a MegaBye boundary (something like
0xXXX00000)? I am seeing Linux Kernel crash if I relax that
restriction.

Thanks,
Bhaskara
