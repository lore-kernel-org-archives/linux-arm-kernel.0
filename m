From: davem@davemloft.net (David Miller)
Date: Thu, 02 Aug 2018 14:39:26 -0700 (PDT)
Subject: [PATCH v4 0/8] Add clock config and pm support to bcm iProc
 mdio mux
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180802.143926.1196419242536904239.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>
Date: Wed,  1 Aug 2018 17:53:45 -0700

> The patchset extends the Broadcom iProc mdio mux to add support for
> suspend/resume and the ability to configure the internal clock
> divider. The patchset also sets the scan control register to
> disable external master access.
 ...

Series applied to net-next, thank you.
