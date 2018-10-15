From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Oct 2018 09:33:40 +0200
Subject: [PATCH 0/2] mmc: uniphier-sd: two bug-fixes
In-Reply-To: <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <20181014223311.GE3260@kunai>
 <CAK7LNATPf4mEdH16eZzLg4x3tP-jvXcTWqqY0DgCpmGjt9x9zg@mail.gmail.com>
Message-ID: <20181015073339.GB981@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Some sub-systems rebase, and some do not.
> It is up to the sub-system maintainer.

We used to have a very strict rule to not rebase anything which ends up
in linux-next. Dunno what happened to this rule but I liked it.

> I know what you are saying, but this is how we develop in linux-next.

I wonder about that...

> You need to use "git rebase --onto".

And what about lists with commit IDs tracking patches on their way
upstream? Yes, there is git-patch-id, yet I think it is easier to admit
that incremental changes happen anyway. I know Ulf view differs...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/36f0b364/attachment.sig>
