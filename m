From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 26 Apr 2015 21:58:16 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <1429735986-18592-1-git-send-email-heiko@sntech.de> (Heiko
 Stuebner's message of "Wed, 22 Apr 2015 22:53:04 +0200")
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
Message-ID: <87pp6qk6g7.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko Stuebner <heiko@sntech.de> writes:

> Using orphan clocks can introduce strange behaviour as they don't have
> rate information at all and also of course don't track
Ok, everything works as before on some pxa platforms.

As pxa clocks support is not even fully mainline, this test is not the best you
could get.

Cheers.

-- 
Robert
