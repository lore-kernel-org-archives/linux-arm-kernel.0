From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 May 2014 23:59:29 +0200
Subject: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock
 support
In-Reply-To: <20140513015708.GA29336@verge.net.au>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
 <20140513015708.GA29336@verge.net.au>
Message-ID: <20140513215929.GA3967@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

> Its a getting a little to close to rc6 for me to take this series for v3.16,
> especially considering some bits seem to need tweaking (I am thinking of sci).
> 
> Could you either:
> 
> * Re-post it without the sci changes and
>   I'll look at queuing it up for v3.17 or;

If it is possible and does not cause too much burden for you, I'd prefer
to include it soonish and handle the fixups incrementally. Since it
touches a few files which change a lot, rebasing and retesting is extra
work (done twice for this series IIRC) and thus I'd prefer to do the
clenaups as seperate patches.

So, if no one objects, I'll resend tomorrow with Geerts fixup folded
into my series and retested against latest renesas/devel.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/6c609e84/attachment.sig>
