From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 4 Aug 2014 14:28:47 +1000
Subject: linux-next: build failure after merge of the gpio tree
In-Reply-To: <CAAVeFuJmHX351WQpEo43sQUf+4BHk9QRJqZfJMsgWf8AXH=_8w@mail.gmail.com>
References: <20140729183153.0e77a6f6@canb.auug.org.au>
 <20140729084237.GE31360@ulmo.nvidia.com>
 <CAAVeFuJmHX351WQpEo43sQUf+4BHk9QRJqZfJMsgWf8AXH=_8w@mail.gmail.com>
Message-ID: <20140804142847.408921cf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Mon, 4 Aug 2014 13:10:14 +0900 Alexandre Courbot <gnurou@gmail.com> wrote:
>
> I have sent a patch to fix this. In the meantime, if the merge
> conflict of the GPIO tree on board-paz00.c is solved by taking the
> GPIO version, there is no build error.
> 
> There are a few important patches pending in the GPIO tree that should
> undergo testing - Stephen, do you think you could resolve the conflict
> that way to enable the latest GPIO tree to be tested again?

No, but I will apply that fix patch in my merge of the gpio tree - just
make sure it is applied to the gpio tree before Linus (Torvalds) is
asked to pull it.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/edfa74e2/attachment.sig>
