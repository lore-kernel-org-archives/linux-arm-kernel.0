From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Wed, 6 Aug 2014 06:48:23 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <CAOMZO5BdPKZSV4mQMA+vCJFpZ2KV6fooLNH2TvfvvVto+Eb2JA@mail.gmail.com>
References: <C4A61A5CA4AD2246942F4BA6F20ACB804356534D@ALVA-EXMB04.alv.autoliv.int>
 <20140626140115.GQ32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>
 <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5BdPKZSV4mQMA+vCJFpZ2KV6fooLNH2TvfvvVto+Eb2JA@mail.gmail.com>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB80435750AA@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Could this problem be the same one as reported at:
> http://www.spinics.net/lists/arm-kernel/msg347914.html ?

The problem you link to describes a permanent issue, our problem seems
to be sporadic as most of our tests work fine (at least for a while).

> Which Ethernet PHY do you use? Do you have pull-up in the MDIO line?

Our hardware has the KSZ9021RN PHY, so the MDIO line should be pull-up.

Do you know if there are debug options that could help us determine the
cause of the timeout?

Best regards,
Mattis Lorentzon

***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
