From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 23 Dec 2013 10:46:34 -0700
Subject: [RFC PATCH 2/3] arm64: dts: APM X-Gene PCIe device tree nodes
In-Reply-To: <1387785725-24262-3-git-send-email-tinamdar@apm.com>
References: <1387785725-24262-1-git-send-email-tinamdar@apm.com>
 <1387785725-24262-3-git-send-email-tinamdar@apm.com>
Message-ID: <20131223174634.GD25089@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 01:32:03PM +0530, Tanmay Inamdar wrote:
> This patch adds the device tree nodes for APM X-Gene PCIe controller and
> PCIe clock interface. Since X-Gene SOC supports maximum 5 ports, 5 dts nodes
> are added.

Can you include an lspci dump for PCI DT bindings please? It is
impossible to review otherwise..

Regards,
Jason
