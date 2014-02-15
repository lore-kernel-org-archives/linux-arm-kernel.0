From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:22:36 +0100
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140215102236.GA24242@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 11:19:58AM +0100, Andrew Lunn wrote:
> The process of making most kirkwood boards boot using DT is nearly
> complete. We can now move these boards into mach-mvebu, freeing them
> of the legacy code needed for none-DT systems. At the same time, they
> can become part of ARCH_MULTI_V5.

Patchset can also be found in

https://github.com/lunn/linux.git v3.14-rc1-mvebu-v2

	  Andrew
