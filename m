From: xerofoify@gmail.com (Nick Krause)
Date: Sat, 12 Jul 2014 01:41:42 -0400
Subject: FIX ME in pgtable.h
Message-ID: <CAPDOMVg2-B1=PkZX05jpFUorbygfjtYt=qm-6L-aiDhYZ-T=DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a fix me message I am hitting with cscope on line 317 of this
file about  #define kern_addr_valid(addr)   (1) not being correct.
I am wondering what value this should be set to. Thanks for the advice
so I can remove this fix me from the kernel.
Cheers Nick
