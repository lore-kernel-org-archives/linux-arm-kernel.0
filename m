From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 10 Oct 2015 23:08:02 +0200
Subject: [PATCH 5/5] arm: add missing of_node_put
In-Reply-To: <8655275.vMqHQfLN9g@wuerfel>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-6-git-send-email-Julia.Lawall@lip6.fr>
 <8655275.vMqHQfLN9g@wuerfel>
Message-ID: <20151010230802.71d1c421@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Sat, 10 Oct 2015 23:02:15 +0200, Arnd Bergmann wrote:

> The same for_each_child_of_node() loop has three 'return' statements'
> aside from the 'break' statement here. I think you should change your
> semantic patch to cover both cases.

I think Julia's semantic patch covers both cases, but only the cases
where there is one break or return (though I have essentially zero
Coccinelle knowledge, this is all based on guessing looking at the
semantic patch in the cover letter).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
