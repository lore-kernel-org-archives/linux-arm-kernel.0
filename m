From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Jan 2016 16:28:02 +0000
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160121154649.GE3997@lukather>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
 <20160118162538.GH6588@sirena.org.uk>
 <20160121154649.GE3997@lukather>
Message-ID: <20160121162802.GL6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 04:46:49PM +0100, Maxime Ripard wrote:

> I guess a separate driver would make it easier to deal with cases like
> the one you suggested (shutting down when the load is going to be
> lower). I don't see how we could have a good DT representation of that
> if we're going to use lists.

We can have a driver regardless of what the DT looks like, it's a
question of how things get instantiated.

> Anyway, I'm fine with both approaches, just let me know what you
> prefer.

Without seeing an implementation of the lists it's hard to say.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/32f95c74/attachment.sig>
