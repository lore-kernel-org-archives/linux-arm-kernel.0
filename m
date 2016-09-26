From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Sep 2016 09:33:22 -0700
Subject: [linux-sunxi] [PATCH v6 0/3] ASoC: sun4i-codec: Distinguish
 sun4i from sun7i
In-Reply-To: <20160925100827.5dc3240d@scratchpost.org>
References: <20160924200503.10728-1-dannym@scratchpost.org>
 <20160925100827.5dc3240d@scratchpost.org>
Message-ID: <20160926163322.bwnmgwkq4v45epa3@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 25, 2016 at 10:08:27AM +0200, Danny Milosavljevic wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> I see that the v5 patches 2 and 3 have already been applied in the mean time  - and the functional content in v6 is identical.

> Therefore, the only thing that needs to be looked at is patch 1 - where I modified the commit message only compared to v5.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160926/98dad3ce/attachment-0001.sig>
