From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Thu, 14 Aug 2014 14:43:56 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
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
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB80435776D3@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio and Russell,

> A working theory is that the switch (3Com Switch 4400) triggers the
> degeneration of the network stack from which Linux does not seem to
> recover, even if we later bypass the switch and directly connect the board to
> the server machine.

After a few more tests we have finally been able to trigger the exact same stalls
on the Sabrelite board with a direct network connection (i.e. without the switch).

Best regards,
Mattis Lorentzon

***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
