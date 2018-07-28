From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 23:32:33 +0200
Subject: [PATCH v2 0/7] Add clock config and pm support to bcm iProc mdio
 mux
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728213233.GH4792@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:23:26PM -0700, Arun Parameswaran wrote:
> Hi,
> The patchset is based on David Miller's "net-next" repo.
> 
> The patchset extends the Broadcom iProc mdio mux to add support for
> suspend/resume and the ability to configure the internal clock
> divider. The patchset also sets the scan control register to
> disable external master access.

Hi Arun

It would be good to modify the .dtsi files to make use of the new
clock properties.

      Andrew
