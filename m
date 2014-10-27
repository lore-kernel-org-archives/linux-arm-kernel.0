From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 27 Oct 2014 08:57:49 +0100
Subject: [PATCH v2] i2c:at91: add bound checking on SMBus block length
 bytes
In-Reply-To: <20141023134927.GQ7443@ldesroches-Latitude-E6320>
References: <1408585181-10131-1-git-send-email-mark.roszko@gmail.com>
 <20141021071434.GI7443@ldesroches-Latitude-E6320>
 <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
 <20141023134927.GQ7443@ldesroches-Latitude-E6320>
Message-ID: <20141027075749.GA1284@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Wolfram took in the patch quietly awhile back. It's in the 3.17 kernel
> > and backported to some of the older trees.
> > https://github.com/torvalds/linux/commit/75b81f339c6af43f6f4a1b3eabe0603321dade65
> 
> Great, sorry for the noise so. It seems I have checked it from a wrong
> branch.

Yes, usually I send out mails when applying patches. Dunno why I missed
it here.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/9cec37aa/attachment.sig>
