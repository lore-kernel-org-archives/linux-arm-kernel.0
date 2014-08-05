From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Tue, 5 Aug 2014 13:31:29 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <20140627163108.GP32514@n2100.arm.linux.org.uk>
References: <C4A61A5CA4AD2246942F4BA6F20ACB804356534D@ALVA-EXMB04.alv.autoliv.int>
 <20140626140115.GQ32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>
 <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell!

> Now because things have changed during the last merge window, I've got an
> even bigger problem sorting through that patch set and getting it back into a
> submittable state.  I've just sent out v2 for it onto the
> netdev at vger.kernel.org mailing list.
> 
> The initial version (marked RFC) attracted very little interest from testers, or
> acks.  I'd very much like to have some testing of it, so if you want to try it out,
> I can provide you with a git URL, patches or a combined patch.

We have applied your V2 patch set of 30 patches on top of v3.16-rc2 and are
currently running some stability tests.

During our first test round we triggered a timeout which caused the fec driver
to become unresponsive for several minutes. The attached backtrace was
shown when the hardware was rebooted.

Best regards,
Mattis Lorentzon

***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: fec-transmit-queue-timed-out.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140805/048707db/attachment-0001.txt>
