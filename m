From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Sep 2012 20:28:20 +0100
Subject: [PATCH] ARM: avoid undef on ARCH_HAS_READ_CURRENT_TIMER
In-Reply-To: <504F836D.6050302@ti.com>
References: <1347380341-28145-1-git-send-email-cyril@ti.com>
 <20120911162522.GE32234@mudshark.cambridge.arm.com> <504F6DFB.5030208@ti.com>
 <20120911172018.GG32234@mudshark.cambridge.arm.com> <504F74C5.2020805@ti.com>
 <20120911175332.GI32234@mudshark.cambridge.arm.com> <504F836D.6050302@ti.com>
Message-ID: <20120911192820.GT13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 02:31:09PM -0400, Cyril Chemparathy wrote:
> On 9/11/2012 1:53 PM, Will Deacon wrote:
>> On Tue, Sep 11, 2012 at 06:28:37PM +0100, Cyril Chemparathy wrote:
>>> I can re-verify with the respun 7530/1 if you'd like.
>>
>> Sure, submitted as 7533/1:
>>
>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7533/1
>>
>
> Works great.

Cyril, I notice you're trying repeatedly to get a new password out of
the system.

TI's mail system is known to silently drop the password reminders.

Please bug your IT provider about this, there's nothing I can do about
it at my end - (and as such you won't receive a password reminder until
something can be done about this.)

2012-09-11 19:45:53 1TBVT2-0008P4-2U => cyril at ti.com R=verp_domain_dnslookup T=verp_domain_smtp S=1041 H=ti.com.s9a1.psmtp.com [74.125.148.10] X=TLSv1:AES256-SHA:256 DN="/C=US/ST=California/L=Mountain View/O=Google Inc/CN=*.psmtp.com" C="250 Thanks"
2012-09-11 20:14:27 1TBVuf-0008S4-EC => cyril at ti.com R=verp_domain_dnslookup T=verp_domain_smtp S=1041 H=ti.com.s9a1.psmtp.com [74.125.148.10] X=TLSv1:AES256-SHA:256 DN="/C=US/ST=California/L=Mountain View/O=Google Inc/CN=*.psmtp.com" C="250 Thanks"

(Note that *.psmtp.com seems to actually be more trouble than its
worth... previous history has shown it to be quite broken, silently
dropping _real_ emails as well.  I'd call it an anti-HAM service rather
than an anti-SPAM service.  The more people complain to Google about it
the better chance it will get fixed.)
