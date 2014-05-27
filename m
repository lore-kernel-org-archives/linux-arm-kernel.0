From: stano@meduna.org (Stanislav Meduna)
Date: Tue, 27 May 2014 18:38:33 +0200
Subject: [PATCH] arm: Set hardirq tracing to on when idling
In-Reply-To: <4559339.apo3Fd10HK@wuerfel>
References: <1401045323-7116-1-git-send-email-minyard@acm.org>
 <4559339.apo3Fd10HK@wuerfel>
Message-ID: <5384BF89.6010509@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.05.2014 11:26, Arnd Bergmann wrote:

> It seems like the right thing to do, I just don't understand
> why nobody hit this before.

Looks like this is what I did hit a month ago and
was not able to find the culprit:
http://www.spinics.net/lists/linux-rt-users/msg11656.html

> How exactly do you see this manifest? If it's clear
> that the trace comes from the idle function, maybe
> everybody just ignores it?

That was definitely what I did ;)

-- 
                                       Stano
