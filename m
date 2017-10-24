From: andrea.adami@gmail.com (Andrea Adami)
Date: Tue, 24 Oct 2017 10:43:32 +0200
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <CAAQYJAu0u9ofdjDGFfrPcw7DJQVk8S1iyt2rTsSAOOBZUXFctw@mail.gmail.com>
References: <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
 <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
 <87mv4txuid.fsf@belgarion.home>
 <20171015104640.hazujjkbqyik7fgg@darkstar.musicnaut.iki.fi>
 <f1631768-b26e-62ae-db1f-65686cd0c4de@gmail.com>
 <CAAQYJAsmOr2qnykO=rWH1N43q3+d27aHMAyXHTXMYpPQ1=9ikA@mail.gmail.com>
 <26e751ec-7fc7-475a-5603-2fac4e0700cb@gmail.com>
 <CAAQYJAuxMHGiyMCFqryYa6QGrXd1JHZnTG60VSGnG6hu9zhitA@mail.gmail.com>
 <443102ff-9793-a938-1392-9baca727cb98@gmail.com>
 <20171018104432.GR20805@n2100.armlinux.org.uk>
 <d994b39f-32bc-e073-ac11-8189ab3d250f@gmail.com>
 <CAAQYJAu0u9ofdjDGFfrPcw7DJQVk8S1iyt2rTsSAOOBZUXFctw@mail.gmail.com>
Message-ID: <CAAQYJAtfbUERyvsewGNp1vgMM2MT6dNGWstL6UsfhLFLJDavMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 10:34 AM, Andrea Adami <andrea.adami@gmail.com> wrote:
> Hi,
>
> good news!
>
> The patch found in the other thread [1] does fix the issue.
> Kernel 4.13 is booting now on corgi: I'll test 4.4 as countercheck.
>
> Regards
> Andrea
>
>
> [1]
> https://patchwork.kernel.org/patch/9944519/


Maybe it is unclear, it was a gcc7 bug finally,

https://github.com/gcc-mirror/gcc/commit/f59996b56aaa1c1d62a16cbb4010775b624cbde0


No other patches have been applied.

Regards
Andrea
