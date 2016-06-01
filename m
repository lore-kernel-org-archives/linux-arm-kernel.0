From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 09:39:50 -0500
Subject: [PATCH 1/2] freescale/dts: add pcie aer interrupt-name property
 in the dts
In-Reply-To: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
References: <1464242349-15323-1-git-send-email-po.liu@nxp.com>
Message-ID: <20160601143950.GA1817@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 01:59:09PM +0800, Po Liu wrote:
> Freescale some platforms aer interrupt was not MSI/MSI-X/INTx

some or all?

> but using interrupt line independently. This patch add a "aer"
> interrupt-names for aer interrupt.

You are not adding, but replacing the interrupt. This needs a better 
explanation as you are breaking compatibility.

Rob
