From: olof@lixom.net (Olof Johansson)
Date: Thu, 15 Aug 2013 23:26:09 -0700
Subject: [GIT PULL 1/2] ARM: mvebu: MSI/PCI changes for v3.12
In-Reply-To: <20130814191011.GD13964@titan.lakedaemon.net>
References: <20130814191011.GD13964@titan.lakedaemon.net>
Message-ID: <20130816062609.GF7035@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 14, 2013 at 03:10:11PM -0400, Jason Cooper wrote:

>       PCI: msi: add default MSI operations for !HAVE_GENERIC_HARDIRQS platforms

I can't find this patch posted anywhere, and it lacks acks. For trivial code in
your own subsystem that's sometimes ok, but this cuts across to PCI.


-Olof
