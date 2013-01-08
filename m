From: davem@davemloft.net (David Miller)
Date: Mon, 07 Jan 2013 19:52:59 -0800 (PST)
Subject: [PATCH 3.8-rc] net: mvneta: fix driver operation in SMP context
In-Reply-To: <20130107164415.GI5075@titan.lakedaemon.net>
References: <1357576074-24245-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107164415.GI5075@titan.lakedaemon.net>
Message-ID: <20130107.195259.1760491533497807910.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Cooper <jason@lakedaemon.net>
Date: Mon, 7 Jan 2013 11:44:15 -0500

> I'll assume this is going through -net, let me know if it should be
> otherwise.

It needs to be fixed up before it can be applied anywhere, see
Ben Hutchings's feedback.
