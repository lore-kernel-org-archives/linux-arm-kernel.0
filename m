From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jan 2012 16:46:24 +0000
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
In-Reply-To: <4F0DB16B.3010302@atmel.com>
References: <20120111133146.990e2b7115c9fa80e8fc3234@canb.auug.org.au>
 <201201111450.02798.arnd@arndb.de> <4F0DB16B.3010302@atmel.com>
Message-ID: <201201111646.24731.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 January 2012, Nicolas Ferre wrote:
> I am so astonished and sad about all this! I have the feeling of having
> done exactly what Guennadi and Olof had asked me to do: What I get at
> the end: people having a bad feeling about my work, not expected merge
> conflicts which annoy everybody (only for a ridiculous amount of code),
> my patches delayed and a comment saying that I cannot handle simple
> dependency...
> Nice result!

I'm sorry for accusing you, you are right. You did exactly what was
agreed on in the mail thread, I just reread the history.

My impression is that Guennadi simply didn't know what he was doing
when he sent you a patch based on a branch that was clearly not
stable.

> - Guennadi did not want to take SoC/board code in his tree
> => I had to take those lines of code through at91/arm-soc breaking the
>    patch series and allowing the introduction of an out-of-sync merge

This was probably the first mistake. It would have been trivial
to handle all this if we had just stuck the same commit into both
trees.

> I have understood and approved all the reasons for the requested
> changes, of course. But for which gain?
> 
> Ok... well, it looks like a massive incomprehension which took us time
> and ends up by wastefulness.

Agreed. How about if you rebase the few other (non-ISI) patches that
I had in arm-soc onto v3.2 and send me an updated pull request so
I can send them on? There's no reason to hold them up.

	Arnd
