From: madhu.sk89@gmail.com (Madhu K)
Date: Tue, 14 Feb 2017 13:05:43 +0530
Subject: Debug kernel oops
Message-ID: <CAA2oCO=48kuhqZC1pK4NhgWS=FFexRwoak4ks9aRaHoYNmESTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

How to debug the kernel oops for arm boards?

Below is my board and setup details.

1) I am using Beaglebone black board which is running with 4.9.2 kernel
version.
2) I wrote some i2c driver on host machine, it is cross compiled for arm
and loaded on beaglebone black.
3) Insmod is proper, but while unloading the module I am seeing some kernel
oops.
4) How to debug that oops? which tools we have to use?

Thanks in advance
Madhu
