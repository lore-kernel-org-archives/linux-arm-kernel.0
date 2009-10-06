From: turanammo@gmail.com (Nicholas Van Orton)
Date: Tue, 6 Oct 2009 17:40:36 +0530
Subject: ARM1176 register writes are in reverse?
Message-ID: <b9e8fcbd0910060510y3dd9ea36x6c97db47f0dfc886@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed that register writes to ARM1176 need to be in the reverse
order. That is, lets say I need to write 0xABCD to a register. But in
the actual write using __raw_writel() the value needs to be changed to
0xCDAB. Why is this so? The Davinci or OMAP on the other hand for
example, which is an ARM 926 does not need any such manipulation. Why
is the ARM1176 an exception?

Thanks,
Nicholas
