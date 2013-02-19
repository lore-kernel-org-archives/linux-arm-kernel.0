From: olof@lixom.net (Olof Johansson)
Date: Tue, 19 Feb 2013 09:46:29 -0800
Subject: [PATCH] ARM: dove: update dove_defconfig with a few useful options
In-Reply-To: <201302191712.32767.arnd@arndb.de>
References: <1358099647-22323-1-git-send-email-olof@lixom.net>
 <201302191615.40971.arnd@arndb.de>
 <20130219164319.GO23237@titan.lakedaemon.net>
 <201302191712.32767.arnd@arndb.de>
Message-ID: <CAOesGMjbY874wr8YQeM-0NHtJ9DN6962NUM8XCVXD9wB+TEXmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 9:12 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 February 2013, Jason Cooper wrote:
>> >
>> > I've just tried rebuilding the for-next branch, which turned out very
>> > easy this time, but this one patch is what stuck out: apparently
>> > you had already applied it into for-next, but it is not on
>> > any of the other branches. Do you know what is going on here?
>>
>> crap, should I not have pulled it?
>
> I don't think you did anything wrong with this, I just don't know
> why it's in for-next.

You did nothing wrong, Jason. This was my mess-up, I was working on
top of for-next instead of for-next~0, which I usually do when doing
small local changes, and it accidentally got included in a push.

> Was this part of your pull requests from last friday?

I believe they were, yes. But I haven't looked much at those yet.


-Olof
