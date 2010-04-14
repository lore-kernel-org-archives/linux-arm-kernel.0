From: rbairva@gmail.com (rd bairva)
Date: Wed, 14 Apr 2010 12:01:51 +0530
Subject: Dmaengine problem
Message-ID: <m2pdbb048f61004132331r7af5c2a7o27c9f43124a35095@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
? ? ? ?I am currently writing dmaengine compatible DMA driver for our ARM
based architecture, But I am facing some performance issues doing
that.

1. dmaengine says callback should run in tasklet, and next transfer
cannot be scheduled from the callback.

Due to these restrictions I am getting some performance issue while
playing sound in our architecture.


Can callback call in DMA driver be placed out of spin_lock to submit
new operations from callback? (only in asynchronous case)

is this Ok? please comment.


Thanks and regards,
Ramdayal
