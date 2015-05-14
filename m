From: slash.tmp@free.fr (Mason)
Date: Thu, 14 May 2015 16:51:10 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150514135353.GY2067@n2100.arm.linux.org.uk>
References: <55520F0F.5010906@free.fr>
 <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr> <20150514135353.GY2067@n2100.arm.linux.org.uk>
Message-ID: <5554B65E.9070809@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/2015 15:53, Russell King - ARM Linux wrote:

> I wonder if clockevents_update_freq() is returning an error - which we
> don't check, and don't print a warning.  It would probably be a very
> good idea to print a warning as a failure to reconfigure the clock
> events code for a different frequency will lead to this kind of issue.

I'll add code to test the return value, and report back here.

Regards.
