From: joe@perches.com (Joe Perches)
Date: Sun, 28 Oct 2012 05:12:15 -0700
Subject: [PATCH 00/16] treewide: Convert dev_printk(KERN_<LEVEL> to
 dev_<level>(
In-Reply-To: <508D0ECA.8040008@mvista.com>
References: <cover.1351411047.git.joe@perches.com>
 <508D0ECA.8040008@mvista.com>
Message-ID: <1351426335.2008.6.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-10-28 at 14:54 +0400, Sergei Shtylyov wrote:
> Hello.

Hi Sergei.

> On 28-10-2012 12:05, Joe Perches wrote:
> 
> > dev_<level> create smaller objects than dev_printk(KERN_<LEVEL>.
> > Convert non-debug calls to this form.
> 
> > Joe Perches (16):
> >    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
> [...]
> >    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
> [...]
> >    tile: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
> 
>     Hm, somehow this patch is repeated thrice?

Nope, I forgot to edit the 0000 file after I edited
patches locally when I noticed I forgot to update
the subject lines.  Patches are corrected, 0000 not.

I don't think it's a bit deal, I could repost just the 0000
if you want though.

cheers, Joe
