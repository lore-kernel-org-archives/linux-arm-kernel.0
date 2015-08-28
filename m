From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 28 Aug 2015 11:53:49 +0200
Subject: [PATCH 1/4] x86, efi, kasan: #undef memset/memcpy/memmove per
 arch.
In-Reply-To: <20150828083941.GN10728@bivouac.eciton.net>
References: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
 <1440605707-8325-2-git-send-email-ryabinin.a.a@gmail.com>
 <20150828062745.GB1928@gmail.com>
 <20150828083941.GN10728@bivouac.eciton.net>
Message-ID: <20150828095349.GA23114@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Leif Lindholm <leif.lindholm@linaro.org> wrote:

> > > So let's move these #undef mem* into arch's asm/efi.h which is
> > 
> > s/lets
> 
> No, that one is actually correct. Abbreviation of let us.

Indeed.

Thanks,

	Ingo
