From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jun 2015 22:18:57 +0100
Subject: Build regressions/improvements in v4.1
In-Reply-To: <CAMuHMdXprKyxirhUZBzNV97oxymcMqeugKixTEC8ojcMq3EeDw@mail.gmail.com>
References: <1435006096-12470-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXprKyxirhUZBzNV97oxymcMqeugKixTEC8ojcMq3EeDw@mail.gmail.com>
Message-ID: <20150622211857.GY7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 10:52:13PM +0200, Geert Uytterhoeven wrote:
> On Mon, Jun 22, 2015 at 10:48 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.1[1] to v4.1-rc8[3], the summaries are:
> >   - build errors: +44/-7
> 
>   + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
> 'L_PTE_MT_BUFFERABLE' undeclared here (not in a function):  => 81:10
>   + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
> 'L_PTE_MT_DEV_CACHED' undeclared here (not in a function):  => 117:10
>   + /home/kisskb/slave/src/arch/arm/mm/dump.c: error:
> 'L_PTE_MT_DEV_NONSHARED' undeclared here (not in a function):  =>
> 108:10

I'm rather ignoring this because I don't see these errors here.  This
is one of the problems of just throwing out build reports.  With zero
information such as a configuration or a method on how to cause the
errors, it's pretty much worthless to post errors.

Folk who do build testing need to be smarter, and consider what it's
like to be on the receiving end of their report emails...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
