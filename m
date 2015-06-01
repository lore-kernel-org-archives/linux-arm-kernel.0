From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 1 Jun 2015 10:25:11 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20150601102511.316f0262@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/zynq-7000.dtsi between commit 9eeb5161397a ("ARM:
zynq: DT: Use the zynq binding with macb") from Linus' tree and commit
4481b18b7cf0 ("ARM: zynq: DT: Use the zynq binding with macb") from the
arm-soc tree.

I fixed it up (it looks like that latter is a newer version of the
former, so I used it) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/33a0088b/attachment.sig>
