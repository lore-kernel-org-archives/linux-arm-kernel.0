From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 3 May 2013 11:03:18 +1000
Subject: [GIT PULL] Removal of GENERIC_GPIO
In-Reply-To: <20130503105234.6e9c8aa5ed2784bbe084caa8@canb.auug.org.au>
References: <51823DDA.7010103@nvidia.com>
 <20130503105234.6e9c8aa5ed2784bbe084caa8@canb.auug.org.au>
Message-ID: <20130503110318.0d30b773852640ee94ba07b5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

On Fri, 3 May 2013 10:52:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I currently have 3 merge fix patches for the gen-cpio tree:
> 
> gen-gpio: GPIOLIB merge fix up
> merge fix for Convert selectors of GENERIC_GPIO to GPIOLIB
> merge fix 2 for Convert selectors of GENERIC_GPIO to GPIOLIB
> 
> I have attached them.  All three are now applicable to Linus' tree.

Just to absolutely clear, I *do not* expect either of you to rebase your
trees or backmerge Linus' tree to fix these, I *do* expect whoever send
this stuff to Linus to mention the necessary fixes to him.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/a41230ca/attachment.sig>
