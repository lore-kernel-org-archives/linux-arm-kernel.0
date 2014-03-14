From: horms@verge.net.au (Simon Horman)
Date: Fri, 14 Mar 2014 09:28:12 +0900
Subject: [PATCH 0/2] ARM: shmobile: koelsch, lager: Annotate clk_names
 with __initconst
In-Reply-To: <CAMuHMdXpXDv8C6b1T+LyE8BSnhdD4dPq_HF6O3OY7Aev+EFfXA@mail.gmail.com>
References: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXpXDv8C6b1T+LyE8BSnhdD4dPq_HF6O3OY7Aev+EFfXA@mail.gmail.com>
Message-ID: <20140314002811.GC28137@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 09:28:23AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 13, 2014 at 7:29 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add __initconst annotations to recently added clk_names.
> >
> > Depends on
> > "[PATCH v2 00/03] ARM: shmobile: Break out and extend clock workaround V2"
> >
> > Simon Horman (2):
> >   ARM: shmobile: koelsch: Annotate clk_names with __initconst
> >   ARM: shmobile: lager: Annotate clk_names with __initconst
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, I will queue these up.
