From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Feb 2011 21:55:09 +0000
Subject: Question About Linux Memory Mapping
In-Reply-To: <AANLkTinUoFzzx4hM8SpUt-mpjn1Z5xmrDqmXwuELuu3e@mail.gmail.com>
References: <AANLkTinUoFzzx4hM8SpUt-mpjn1Z5xmrDqmXwuELuu3e@mail.gmail.com>
Message-ID: <20110218215509.GB19427@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 09:56:28PM +0100, Drasko DRASKOVIC wrote:
> Hi all,
> in the article Booting ARM Linux :
> http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html
> I can see that mem map is passed via ATAG_MEM. However, in the same
> article it is mentioned that this information can also be passed via
> kernel command line paramters,  mem=<size>[KM][,@<phys_offset>].

Why do you discard this information soo lightly?  Did you try it?

> However, this does not seem to be true, as "mem" command line
> parameter seems to be formated like this : mem= n[KMG] (i.e. no
> offset), regarding to this reference :
> http://oreilly.com/linux/excerpts/9780596100797/kernel-boot-command-line-parameter-reference.html.
> Seems like memmap should be used instead.

Maybe O'Reilly is outdated?
