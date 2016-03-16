From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 16 Mar 2016 13:07:49 +0100
Subject: [PATCH v4 2/2] power: reset: at91-shdwc: add new shutdown
 controller driver
In-Reply-To: <56E94558.9010506@atmel.com>
References: <1457624260-30350-1-git-send-email-nicolas.ferre@atmel.com>
 <1457624260-30350-3-git-send-email-nicolas.ferre@atmel.com>
 <20160314202205.GA24894@piout.net> <56E94558.9010506@atmel.com>
Message-ID: <20160316120749.GC20227@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/2016 at 12:36:56 +0100, Nicolas Ferre wrote :
> I don't agree with you on the 2 last ones. In Documentation/CodingStyle,
> it is said that:
> 
> "Chapter 2: Breaking long lines and strings
> [..]
> Descendants are always substantially shorter than the parent and
> are placed substantially to the right."
> 
> Together with the 80 column requirement that I also fulfil, I think that
> my code is well aligned.
> 
> So I keep it like this ;-)
> 

checkpatch.pl --strict disagrees with you


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
