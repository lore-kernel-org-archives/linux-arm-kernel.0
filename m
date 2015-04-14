From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 14 Apr 2015 08:16:24 +0200
Subject: [GIT PULL RESEND] pxa: for-next v4.1
In-Reply-To: <201504140146.16720.arnd@arndb.de> (Arnd Bergmann's message of
 "Tue, 14 Apr 2015 01:46:16 +0200")
References: <87ioe08y4b.fsf@free.fr> <87vbh2pi3m.fsf@free.fr>
 <201504140146.16720.arnd@arndb.de>
Message-ID: <873843jkuf.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Saturday 11 April 2015, Robert Jarzmik wrote:
>> This is the pxa changes for v4.1 cycle.
>> 
>> The main and only feature is the conversion of all pxa variants to clock
>> framework. This encompasses pxa25x, pxa27x and pxa3xx, for all boards.
>> 
>> This should be a disruptive cycle in the normally quiet pxa history, as
>> the change can break any platform, and the test were performed on only 4
>> boards (lubbock, zylonite, mioa701, cm-x300).
>
> Hi Robert,
>
> We screwed up here and missed the pull requests earlier. I thought
> about putting them in the late branch now, but as they had no time in
> linux-next before the merge window, I think it's way too risky.
OK, it happens. And agreed, it is too risky, this is one of my major changes.

> Please submit again after 4.1-rc1. Feel free to nag us much earlier
> if you get the impression that we missed something you wanted us
> to pick up.
All right, let's do that.

Cheers.

-- 
Robert
