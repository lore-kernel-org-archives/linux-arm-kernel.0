From: ananaza@iki.fi (Antti P Miettinen)
Date: Mon, 27 Jan 2014 14:48:15 +0200 (EET)
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
 <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
Message-ID: <20140127.144815.1048814583962628826.apm@brigitte.kvy.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> That's why I defined the worst case. How did you implemented it in your
> idle drivers ? That would help generalize it, after all these bindings
> are there to simplify drivers upstreaming, feedback welcome.

Currently we do not handle this well downstream either. The problem
with worst case is that the absolute worst case can be really bad and
probability of it might be very low. Sorry - no ready answer :-)

	--Antti
