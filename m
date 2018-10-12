From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 12 Oct 2018 13:43:57 +1100
Subject: next-20181008 build: 2 failures 22 warnings (next-20181008)
In-Reply-To: <20181012103758.51c7befa@canb.auug.org.au>
References: <E1g9cV0-0008Sg-4U@optimist> <20181008211109.GA4440@sirena.org.uk>
 <20181008213018.GL6490@zn.tnic>
 <20181010152704.337ee630@canb.auug.org.au>
 <20181010043358.GA5924@zn.tnic>
 <20181012103758.51c7befa@canb.auug.org.au>
Message-ID: <20181012134357.51bfd026@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Fri, 12 Oct 2018 10:37:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Wed, 10 Oct 2018 06:33:59 +0200 Borislav Petkov <bp@suse.de> wrote:
> >
> > On Wed, Oct 10, 2018 at 03:27:04PM +1100, Stephen Rothwell wrote:  
> > > I have added that to linux-next today (pending this or something else
> > > turning up in the tip tree).    
> > 
> > I have queued a fixed version in the meantime:
> > 
> > https://git.kernel.org/tip/9d94e8b1d4f94a3c4cee5ad11a1be460cd070839  
> 
> OK, I will use that until it turns up in the tip auto-latest branch.

It turns out that I can't use that since it is mostly already in the
tip tree as commit

  3a387c6d96e6 ("x86/kaslr, ACPI/NUMA: Fix KASLR build error")

So I will stick with my incremental patch for now.

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181012/2ee2a938/attachment.sig>
