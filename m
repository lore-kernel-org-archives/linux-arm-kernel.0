From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 18:45:11 +0100
Subject: [PATCH 05/10] ARM: dts: sun9i: Add mmc config clock nodes
In-Reply-To: <CAGb2v67=D+7vO3QoC5VcUcWAJtFLDLs_+XzZqQA4=cBLPdratg@mail.gmail.com>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-6-git-send-email-wens@csie.org>
 <20141207150039.GE12434@lukather>
 <CAGb2v67=D+7vO3QoC5VcUcWAJtFLDLs_+XzZqQA4=cBLPdratg@mail.gmail.com>
Message-ID: <20141207174511.GM12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 12:00:21AM +0800, Chen-Yu Tsai wrote:
> As it is a platform driver, it can't be under the clocks node, which
> doesn't instantiate platform devices. (That is, assuming you're ok
> with it being a platform driver.)

That shouldn't have any impact on the DT itself, but yeah, you're
right.

I guess we should just kill that clocks node for memory mapped clocks
one day.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/386251cd/attachment.sig>
