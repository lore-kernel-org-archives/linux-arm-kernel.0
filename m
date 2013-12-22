From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 11:37:19 -0800
Subject: arm-soc: Xilinx Zynq dt changes for v3.14
In-Reply-To: <52AAC671.6000207@monstr.eu>
References: <52AAC671.6000207@monstr.eu>
Message-ID: <20131222193719.GA9144@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:33:53AM +0100, Michal Simek wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please pull these dt changes to your tree.

Pulled, however:

> Soren Brinkmann (2):
>       arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
>       arm: dt: zynq: Add 'cpus' node
> 
> Steffen Trumtrar (1):
>       ARM: zynq: add gem support

Minor nit: Please be consistent with patch subjects. We try to stick to:

ARM: <platform>: <...>


-Olof
