From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Apr 2017 17:06:19 +0100
Subject: [PATCH 2/6] regulator: anatop: only set supply regulator when it
 actually exists
In-Reply-To: <CAA+hA=QG7xwJrX0q3fyTEAHEcwJr-0z0T+MvC2ESDpBGrhQVRA@mail.gmail.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-2-git-send-email-aisheng.dong@nxp.com>
 <20170411203124.y7cwyttqfu4a2aov@sirena.org.uk>
 <20170413071101.GA23163@b29396-OptiPlex-7040>
 <20170412155336.vhhrftqmlxhti36n@sirena.org.uk>
 <CAA+hA=QG7xwJrX0q3fyTEAHEcwJr-0z0T+MvC2ESDpBGrhQVRA@mail.gmail.com>
Message-ID: <20170412160619.lz7jehm5bivoqwgn@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 12:00:36AM +0800, Dong Aisheng wrote:

> It can solve the problem.
> But it breaks some thing and need a further tiny fix.
> I just replied the mail in your patch thread.
> Please check it!

OK, I'll look out for your mail (I've not seen it yet, guess it's got
held up).  Thanks for testing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/635e41c0/attachment.sig>
