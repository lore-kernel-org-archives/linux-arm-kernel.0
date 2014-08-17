From: ipaton0@gmail.com (Iain Paton)
Date: Sun, 17 Aug 2014 22:34:46 +0100
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <C4A61A5CA4AD2246942F4BA6F20ACB8043577770@ALVA-EXMB04.alv.autoliv.int>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435776D3@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B7FgzB7ThVyV2Vk7wTwYgjRWjEnkkAN5uwwKMaBKq1yg@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043577770@ALVA-EXMB04.alv.autoliv.int>
Message-ID: <53F11FF6.8030303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/14 06:42, Mattis Lorentzon wrote:

> We mostly run SSH with benchmarks using NFS, it can probably be
> triggered by using only SSH with the following loop:
> 
> # while : ; do ssh arm-card date; done

Mattis,

What sort of time does it take for you to see a problem?

I've been running the above for nearly two days on 3.16.0 on a board 
with fec interrupts routed through gpio_6 and haven't seen a hint of 
a problem.
