From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Mar 2014 20:23:53 -0500
Subject: linux-next: manual merge of the keystone tree with the arm-soc
 tree
In-Reply-To: <5330C703.5030705@ti.com>
References: <20140325105501.e63fcdd78d0d604b4e5309a1@canb.auug.org.au>
 <5330C703.5030705@ti.com>
Message-ID: <20140325012353.GA25643@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 08:00:03PM -0400, Santosh Shilimkar wrote:
> On Monday 24 March 2014 07:55 PM, Stephen Rothwell wrote:
> > Hi Santosh,
> > 
> > Today's linux-next merge of the keystone tree got a conflict in
> > arch/arm/boot/dts/Makefile between commit ba5a37e52194 ("ARM: mvebu: Move
> > kirkwood DT boards into mach-mvebu") from the arm-soc tree and commit
> > 400550ae7e77 ("ARM: dts: Build all keystone dt blobs") from the keystone
> > tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary (no action
> > is required).
> > 
> Looks fine. Thanks

wow, not even a mention of my original patch [1]. I also couldn't find
your patch [2] anywhere in the mailing list archives, not even google
could find it. The only place that commit was ever mentioned was this
very thread.

The patch I wrote was valid for v3.14-rc7 (the base where it was
written), I'd expect to, at a minimum, have a mention or a Reported-by
or at least see your patch in the mailing list.

Anyway, it's just a patch. Nevermind.

[1] http://marc.info/?l=linux-arm-kernel&m=139463982310448&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux-keystone.git/commit/?h=next&id=400550ae7e778302a45d2952ac75907903e2610c

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/4293d907/attachment.sig>
