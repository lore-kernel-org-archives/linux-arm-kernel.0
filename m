From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Mar 2016 11:23:07 -0700
Subject: [PATCH resend v5 1/3] ASoC: cygnus: Add DT bindings for Broadcom
 Cygnus audio
In-Reply-To: <CAES42Na+wM6P5yB3tg+bxk88txQA+52kgL8uwFqEW1XO8LfUeQ@mail.gmail.com>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <1459277192-10942-2-git-send-email-simran.rai@broadcom.com>
 <20160331141308.GA9670@rob-hp-laptop>
 <CAES42Na+wM6P5yB3tg+bxk88txQA+52kgL8uwFqEW1XO8LfUeQ@mail.gmail.com>
Message-ID: <20160331182307.GQ2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 11:14:53AM -0700, Simran Rai wrote:
> There was a change made in v4 that introduced assigned-clocks,
> assigned-clock-parents, and assigned-clock-rates, to allow initial
> configuration of
> default parent clock and its frequency.

...all of which are standard clock binding properties.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/7961a607/attachment.sig>
