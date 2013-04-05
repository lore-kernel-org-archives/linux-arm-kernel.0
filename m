From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 5 Apr 2013 15:34:53 +1100
Subject: linux-next: manual merge of the arm-soc tree with the xilinx tree
In-Reply-To: <20130405153335.baf29606a97b1bee415f3546@canb.auug.org.au>
References: <20130405153335.baf29606a97b1bee415f3546@canb.auug.org.au>
Message-ID: <20130405153453.75b76d68fe9adc6e981e02fb@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, 5 Apr 2013 15:33:35 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-spear/spear13xx.c between commit c79e33b3e828 ("ARM:
> smp_twd: convert to use CLKSRC_OF init") from the xilinx tree and commit
> 2b9c613c4ee1 ("ARM: spear: move generic.h and pl080.h into private dir")
> from the arm-soc tree.

BTW, that xilinx tree commit has no "Signed-off-by" for the committer ...
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/bdfc4265/attachment.sig>
