From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 13:05:41 +1100
Subject: linux-next: build failure after merge of the final tree
 (arm-soc tree related)
In-Reply-To: <CAP=VYLosYNbhGeUYyLr=0xa1UgK=fL-GOafySixFyQjy4GrdgA@mail.gmail.com>
References: <20120315105901.7b10c9f4de9374a613436988@canb.auug.org.au>
 <CAP=VYLosYNbhGeUYyLr=0xa1UgK=fL-GOafySixFyQjy4GrdgA@mail.gmail.com>
Message-ID: <20120315130541.d0d8c98d132a32dfe369ee19@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, 14 Mar 2012 21:53:39 -0400 Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>
> On Wed, Mar 14, 2012 at 7:59 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the final tree, today's linux-next build (powerpc
> > allmodconfig) failed like this:
> >
> > drivers/ata/sata_mv.c:4185:1: error: '__mod_of_device_table' aliased to undefined symbol 'mvsdio_dt_ids'
> >
> > Caused by commit f1e1e148c5cb ("ARM: kirkwood: sata_mv: add device tree
> > binding").
> 
> Looks like the same thing I reported in yesterday's triage that was
> screwing sparc:
> 
> http://www.spinics.net/lists/sparclinux/msg09199.html
> 
> Odd that it only started screwing powerpc today though.

It started affecting PowerPC with next-20120309, but I don't read the
build logs every day :-(

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/6cac43a6/attachment-0001.sig>
