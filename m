From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 2 Oct 2010 20:03:36 +0200
Subject: [PATCH 2/2] gic: Export irq chip functions
In-Reply-To: <1285901335-26354-2-git-send-email-ccross@android.com>
References: <1285901335-26354-1-git-send-email-ccross@android.com>
	<1285901335-26354-2-git-send-email-ccross@android.com>
Message-ID: <AANLkTinSgSWakhXaHN9svA7ruRF6w4tbOugdd5g+xF2i@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/1 Colin Cross <ccross@android.com>:

> Some systems combine the GIC with an external interrupt controller.

Which ones?

In-tree systems (in which case it would be natural to include these changes
the patch series) or stuff you plan to submit later?

Linus Walleij
