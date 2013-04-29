From: gotom@sanori.org (Masanori Goto)
Date: Tue, 30 Apr 2013 06:41:38 +0900
Subject: [PATCH 10/21] [SCSI] nsp32: use mdelay instead of large udelay
 constants
In-Reply-To: <201304291521.14195.arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-11-git-send-email-arnd@arndb.de>
 <CALZLnaFeLcaGM7_McTZ=pKBRnpXk0AvqOTF=1YCqJv-53yk4XQ@mail.gmail.com>
 <201304291521.14195.arnd@arndb.de>
Message-ID: <CALZLnaEbXRJY2qntWucm00mNq78CRD8Vhp7KoTw6Me0frxtaDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, you're absolutely correct.  Thanks for the follow up!  Please
change it as follow as you mentioned:

Acked-by: GOTO Masanori <gotom@debian.or.jp>

Best regrads,
-- gotom

2013/4/29 Arnd Bergmann <arnd@arndb.de>:
> On Friday 26 April 2013, Masanori Goto wrote:
>> 2013/4/25 Arnd Bergmann <arnd@arndb.de>
>> >
>> > ARM cannot handle udelay for more than 2 miliseconds, so we
>> > should use mdelay instead for those.
>> >
>>
>> Singed-off-by: GOTO Masanori <gotom@debian.or.jp>
>
> Thanks. I assume you mean "Acked-by", not "Singed-off" as in "burnt"
> or "Signed-off" as a notification that you have applied it to your
> own git tree.
>
> I'll keep the patch with an your "Acked-by" line in my tree unless
> James wants to apply to the scsi tree.
>
>         Arnd
>
