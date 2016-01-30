From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 30 Jan 2016 11:08:02 +0100
Subject: [PATCH 0/9] ARM: pxa/mmp cleanups and warning fixes
In-Reply-To: <24241162.8H4bJ4YIKl@wuerfel> (Arnd Bergmann's message of "Fri,
 29 Jan 2016 16:48:33 +0100")
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
 <87io2c76hh.fsf@belgarion.home> <24241162.8H4bJ4YIKl@wuerfel>
Message-ID: <877fir7531.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday 29 January 2016 16:25:30 Robert Jarzmik wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> 
>> > These are all fixes for harmless warnings, aside from the first
>> > patch, which is a cleanup. Please pick them up into the PXA
>> > tree (my preference), or provide an Ack so I can put them
>> > into arm-soc.
>> Hi Arnd,
>> 
>> I'll pick them up, provided the acks (for clock tree for example). The
>> pxa-for-4.6 will happen.
>> 
>> I'll just have a check on 1/9 to verify nobody hides in a corner a direct CKEN
>> access, and try to understand more thoroughly 7/9, all the others look good to
>> me.
>
> Ok, sounds good. If you are unsure about it, you can also drop that
> one or do a broader version of it that does the other registers as well.
> I don't think it caused any compiler warnings, which is what I'm trying
> to handle right now.
You're right, I checked and it's good. tc-arm.c in gcc is a good lecture.

I'll queue 1/9 up to 8/9 in pxa/for-next, thanks.

Cheers.

-- 
Robert
