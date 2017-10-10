From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Oct 2017 18:10:47 +0100
Subject: [PATCH v11 7/9] arm64/kasan: add and use kasan_map_populate()
In-Reply-To: <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
References: <20171009221931.1481-1-pasha.tatashin@oracle.com>
 <20171009221931.1481-8-pasha.tatashin@oracle.com>
 <20171010155619.GA2517@arm.com>
 <CAOAebxv21+KtXPAk-xWz=+2fqWQDgp9SAFZz-N=XsuBxev=zcg@mail.gmail.com>
Message-ID: <20171010171047.GC2517@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Tue, Oct 10, 2017 at 01:07:35PM -0400, Pavel Tatashin wrote:
> Thank you for doing this work. How would you like to proceed?
> 
> - If you OK for my series to be accepted as-is, so your patch can be
> added later on top, I think, I need an ack from you for kasan changes.
> - Otherwise, I can replace: 4267aaf1d279 arm64/kasan: add and use
> kasan_map_populate() in my series with code from your patch.

I was thinking that you could just add my patch to the end of your series
and have the whole lot go up like that. If you want to merge it with your
patch, I'm fine with that too.

Will
