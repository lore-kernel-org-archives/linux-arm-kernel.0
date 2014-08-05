From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Aug 2014 10:53:21 -0300
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
References: <C4A61A5CA4AD2246942F4BA6F20ACB804356534D@ALVA-EXMB04.alv.autoliv.int>
 <20140626140115.GQ32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>
 <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
Message-ID: <CAOMZO5BdPKZSV4mQMA+vCJFpZ2KV6fooLNH2TvfvvVto+Eb2JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 5, 2014 at 10:31 AM, Mattis Lorentzon
<Mattis.Lorentzon@autoliv.com> wrote:

> We have applied your V2 patch set of 30 patches on top of v3.16-rc2 and are
> currently running some stability tests.
>
> During our first test round we triggered a timeout which caused the fec driver
> to become unresponsive for several minutes. The attached backtrace was
> shown when the hardware was rebooted.

Could this problem be the same one as reported at:
http://www.spinics.net/lists/arm-kernel/msg347914.html ?

Which Ethernet PHY do you use? Do you have pull-up in the MDIO line?
