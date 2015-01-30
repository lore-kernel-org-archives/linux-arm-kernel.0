From: brucembeach@gmail.com (bruce m beach)
Date: Thu, 29 Jan 2015 20:56:44 -0800
Subject: Unable to boot mainline on snow chromebook since 3.15
Message-ID: <CAArymCnPE10YmaYYV5CXdCTePbgL9b5p_+8+Da2dPK-3CkoNBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everybody

I am trying to boot a mainline kernel on a Samsung exynos
chromebook (snow) and am having (surprise, surprise) some
trouble.  I am somewhat new to this but am getting some sort of
feel for what needs to be done. Having read the postings for
"Unable to boot mainline on snow chromebook since 3.15" I decided
to send this mail under that subject. My question is what is the
latest kernel that actually did boot and is there a current
kernel somewhere that works. I have tried
           3.18.3 and
           3.18.4
The screen goes black and the system reboots to the initial
chrome flash screen. I tried linux-3.14.30 which was better.
After a strange screen of what appeared to be timeing information
the kernel booted (off sda2) and ran normally until the final
message

   Waiting for root device /dev/sda3

which is where the root system was supposed to be and then went
no further. For u-boot I am using the binary

        nv_uboot-snow-simplefb.kpart

   Regards Bruce

PS. please cc me as I am not on the list
