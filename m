From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 24 Apr 2012 18:32:20 -0700
Subject: announcing the clk-next branch
Message-ID: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The clock patches that I have signed-off on and picked from the list
are all rebased on top of 3.4-rc4.  They can be found here:

git://git.linaro.org/people/mturquette/linux.git clk-next

If the branch is missing anything that I have ACK'd then please let me know.

The obvious thing missing are the recent platform ports.  Those folks
probably want to test on top of this branch first so it seemed
premature for me to pull them.  After the recent platform ports go in
then I'll ask for this to head into linux-next.

Regards,
Mike
