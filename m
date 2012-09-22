From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Sat, 22 Sep 2012 15:22:50 +0200
Subject: [PATCH 1/3] i2c: i2c-mux-gpio: Use devm_kzalloc instead of kzalloc
In-Reply-To: <1348241535-27754-2-git-send-email-maxime.ripard@free-electrons.com>
 (Maxime Ripard's message of "Fri, 21 Sep 2012 17:32:12 +0200")
References: <1348241535-27754-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348241535-27754-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <87sjaachud.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:

 Maxime> Use the devm_kzalloc managed function to stripdown the error and remove
 Maxime> code.

 Maxime> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Besides the comment of Jean - 
Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
