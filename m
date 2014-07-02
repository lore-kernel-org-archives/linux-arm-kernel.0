From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Jul 2014 18:27:00 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140702162700.GM20799@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Some independent testing/review of this patch series would definitely
> be welcome.

Hi Thomas

I've not used these platforms much, and have no idea how to trigger
and then detect corruption. I guess Simon Guinot is your best bet for
testing.

	Andrew
