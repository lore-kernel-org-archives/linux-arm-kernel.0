From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 19 Jan 2012 12:12:31 +0100
Subject: mc13xxx: add I2C support
In-Reply-To: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au> (Marc
 Reilly's message of "Thu, 19 Jan 2012 12:01:31 +1100")
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <87lip4kktc.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Reilly <marc@cpdesign.com.au> writes:

> Hi,

Hi,

>
> This series (based on 3.2) adds I2C support for the mc13xxx family PMICs.
> The patches are similar, but not identical to my previous patches for this [1], the
> main difference being the way the config items are done in patch 2.
>
> I don't have the hardware to retest on SPI hardware, I'd appreciate if someone could 
> double check it still works.
>
> I've also got a stack of patches for the mc13xxx to follow, but should get this in
> first.

I've never looked at regmap deeply but can't it be done with regmap or is it
just a bad idea ?

Arnaud
