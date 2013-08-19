From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 19 Aug 2013 16:05:37 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20130819160537.1eeb0a9ebc269def138e016b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got conflicts in various files
between merges and commits in the arm-soc tree and merges in the mvebu
tree.

These merges/commits in the mvebu tree appear to be from a previous
version of the arm-soc tree that the mvebu tree has been rebased upon.
Please don't do that - the arm-soc tree as a whole is not stable.

I fixed it up (I used the version from the current arm-soc tree) and can
carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/b885a7cb/attachment-0001.sig>
