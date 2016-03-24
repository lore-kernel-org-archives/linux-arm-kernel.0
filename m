From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Mar 2016 22:12:31 +0100
Subject: [PATCH] ARM: dts: veyron: enable the tsadc on pinky board
In-Reply-To: <1450607434-6733-1-git-send-email-wxt@rock-chips.com>
References: <1450607434-6733-1-git-send-email-wxt@rock-chips.com>
Message-ID: <2324215.uYLQVgh5FL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Sonntag, 20. Dezember 2015, 18:30:34 schrieb Caesar Wang:
> I think the tsadc is fakly hand on pinky board,
> maybe that's fixed in newest kernel.
> As the following patch is a example:
> https://patchwork.kernel.org/patch/7472051/
> 
> I don't have meet this issue on pinky board.
> Let me know if that's still hanging on pinky board.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

I just gave that a try again on my pinky-rev2. And while the tsadc did produce 
some results and didn't hang the system in my tries, the temperature values 
seemed to be frozen (only changing once on every reboot).

Running the same kernel on a Jerry produced the expected results of the 
temperature changing over time and differing cpu frequencies.

Pinky also is a sort of dinosaur and only you and me seem to still like them 
:-) . And something is definitly strange here, and I'd tend to keep the tsadc 
disabled for the time being. 


Heiko
