From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 26 Apr 2015 11:31:13 +0200
Subject: [PATCH v5 0/3] Fix lubbock and mainstone interrupts
In-Reply-To: <7247485.mMzWTjWY84@wuerfel> (Arnd Bergmann's message of "Sun, 26
 Apr 2015 00:20:58 +0200")
References: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
 <7247485.mMzWTjWY84@wuerfel>
Message-ID: <87pp6rkzha.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Saturday 25 April 2015 23:13:20 Robert Jarzmik wrote:
>> This serie was submitted to the lak list, then migrated to mfd drivers, to end
>> up again here. There was no change since last submission. Let's hope this is the
>> last spin and that these platform will be fixed at last.
>> 
>
> Should these be marked 'Cc: stable at vger.kernel.org'?
I can do this. I thought that 3 patches of 100+ lines, and the fact that these
boards were broken since october 2011 would prevent this serie from reaching the
stable branch.

Well, I'll resubmit with this information, and after comments stage it to my
fixes branch. Let's see what stable tree people will do.

> Can you also add a 'Fixes' tag with the commit that introduced the problem?
Sure.

Cheers.

-- 
Robert
