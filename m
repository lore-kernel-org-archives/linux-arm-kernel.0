From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sat, 14 Jul 2018 12:10:46 +1000
Subject: next/master boot: 184 boots: 13 failed, 171 passed (next-20180711)
In-Reply-To: <20180712100809.10ac3e1d@canb.auug.org.au>
References: <5b45f6df.1c69fb81.86409.6375@mx.google.com>
 <20180711145253.GA9651@sirena.org.uk>
 <CAOMZO5B+LBwAEewEoCn=TojQuZ=qMt+4a8n+tiG9cfnzAta_9w@mail.gmail.com>
 <20180712100809.10ac3e1d@canb.auug.org.au>
Message-ID: <20180714121046.7a9cdf20@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, 12 Jul 2018 10:08:09 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Wed, 11 Jul 2018 12:09:15 -0300 Fabio Estevam <festevam@gmail.com> wrote:
> >
> > This is caused by the following commit in linux-next:
> > 
> > commit f9b6e485fa ("crypto: caam: cleanup CONFIG_64BIT ifdefs when
> > using io{read|write}64")
> > 
> > I have already reported this issue on a linux-next tree from last week
> > and Stephen said he was going to drop such commit:
> > https://patchwork.kernel.org/patch/10507333/
> > 
> > but it reappeared today's linux-next.
> > 
> > Stephen, Andrew
> > 
> > Could you please drop it?  
> 
> OK, I have dropped it (again).

I have just imported the new mmotm, and that patch is still in there.
Has it been fixed, or do I need to remove it again?  (See the above
patchwork entry).

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180714/a70f39da/attachment.sig>
