From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 7 Feb 2011 15:00:30 +0800
Subject: [RFC,
	PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
In-Reply-To: <AANLkTinq=HieqGUFthm04F21RuLijg2mZH+eoan9p5HN@mail.gmail.com>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800990.238556019385.3.gpush@pororo>
	<AANLkTinq=HieqGUFthm04F21RuLijg2mZH+eoan9p5HN@mail.gmail.com>
Message-ID: <201102071500.31276.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> Shouldn't the prepare_count be checked against 0 ?

Yes, you're right, it should be clk->prepare_count == 0.

Will update for the next revision.

Cheers,


Jeremy
