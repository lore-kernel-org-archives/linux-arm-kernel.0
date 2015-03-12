From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 12 Mar 2015 15:55:03 +0100
Subject: [RFC V2 04/12] i2c: opal: make use of the new infrastructure for
 quirks
In-Reply-To: <54FFC3EC.7020708@linux.vnet.ibm.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-5-git-send-email-wsa@the-dreams.de>
 <54FF2631.9050006@linux.vnet.ibm.com>
 <1426029133.17565.9.camel@kernel.crashing.org>
 <54FFC3EC.7020708@linux.vnet.ibm.com>
Message-ID: <20150312145503.GB9572@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I think we can't land up here by-passing the check for quirks so above
> checks are duplicated here..

True.

So, as Ben seems OK with write-then-anything, can you send me your
changes as an incremental patch to mine with your Signed-off, please?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/0817d7c0/attachment-0001.sig>
