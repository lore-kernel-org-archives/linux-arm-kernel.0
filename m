From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Apr 2013 15:21:14 +0200
Subject: [PATCH 10/21] [SCSI] nsp32: use mdelay instead of large udelay
 constants
In-Reply-To: <CALZLnaFeLcaGM7_McTZ=pKBRnpXk0AvqOTF=1YCqJv-53yk4XQ@mail.gmail.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-11-git-send-email-arnd@arndb.de>
 <CALZLnaFeLcaGM7_McTZ=pKBRnpXk0AvqOTF=1YCqJv-53yk4XQ@mail.gmail.com>
Message-ID: <201304291521.14195.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013, Masanori Goto wrote:
> 2013/4/25 Arnd Bergmann <arnd@arndb.de>
> >
> > ARM cannot handle udelay for more than 2 miliseconds, so we
> > should use mdelay instead for those.
> >
> 
> Singed-off-by: GOTO Masanori <gotom@debian.or.jp>

Thanks. I assume you mean "Acked-by", not "Singed-off" as in "burnt"
or "Signed-off" as a notification that you have applied it to your
own git tree.

I'll keep the patch with an your "Acked-by" line in my tree unless
James wants to apply to the scsi tree.

	Arnd
