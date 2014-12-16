From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Tue, 16 Dec 2014 14:50:07 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <C4A61A5CA4AD2246942F4BA6F20ACB80435790DF@ALVA-EXMB04.alv.autoliv.int>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435776D3@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B7FgzB7ThVyV2Vk7wTwYgjRWjEnkkAN5uwwKMaBKq1yg@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043577770@ALVA-EXMB04.alv.autoliv.int>
 <53F11FF6.8030303@gmail.com>
 <CAOMZO5CDvQDD7gVLFStwv4MPrUyqZE3sEDZwb0gukkXujYG-6Q@mail.gmail.com>
 <53F2E89B.80009@gmail.com> <53F5BE3D.5070209@gmail.com>
 <CAOMZO5A3CgaVCKxNDG-zEdwprYdRDXD_XZ2ikW+mns-iieYHsg@mail.gmail.com>
 <53F71D1B.8090004@gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043578CB2@ALVA-EXMB04.alv.autoliv.int>
 <53FDB649.2070506@gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435790DF@ALVA-EXMB04.alv.autoliv.int>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB8054DF9A67@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Now because things have changed during the last merge window, I've got
> an even bigger problem sorting through that patch set and getting it
> back into a submittable state.  I've just sent out v2 for it onto the
> netdev at vger.kernel.org mailing list.
>
> The initial version (marked RFC) attracted very little interest from
> testers, or acks.  I'd very much like to have some testing of it, so
> if you want to try it out, I can provide you with a git URL, patches or a
> combined patch.
 
We have run v3.16 for about three months now, and many millions of ssh
connections on eight separate systems, both without and with your network
patches. Our conclusion is that the patches clearly reduce the number of
network timeouts, and this is a great improvement. However, after a month
or so of uptime, the number of timeouts began to increase again, forcing us
to reboot the cards.

Best regards,
Mattis Lorentzon
***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
