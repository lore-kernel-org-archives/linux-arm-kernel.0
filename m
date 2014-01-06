From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 6 Jan 2014 12:13:17 +1100
Subject: linux-next: manual merge of the sh tree with the  tree
Message-ID: <20140106121317.bada4233ec3fec40f79735cc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Today's linux-next merge of the sh tree got conflicts in
drivers/tty/serial/sh-sci.c and include/linux/serial_sci.h between
commits 8fb9631c517b ("serial: sh-sci: Sort headers alphabetically"),
20bdcab8268c ("serial: sh-sci: Add OF support") and probably others from
the arm-soc tree and commits ada80ee7fa60 ("serial: sh-sci: Add OF
support") and b19ef75c56e9 ("serial: sh-sci: OF definitions need
linux/of.h") from the sh tree.

The arm-soc tree version is dated much more recently than
the sh tree version and conflicts badly, so for today I have just dropped
the sh tree (everything in there was committed before April 2013).  Please
figure this out.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/8224246e/attachment.sig>
