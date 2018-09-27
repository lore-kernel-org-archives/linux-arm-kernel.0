From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 27 Sep 2018 16:33:24 +0200
Subject: [PATCH] ARM: dts: vf610: Add ZII SCU4 AIB board
In-Reply-To: <1538054166-28411-1-git-send-email-festevam@gmail.com>
References: <1538054166-28411-1-git-send-email-festevam@gmail.com>
Message-ID: <20180927143324.GA12979@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 10:16:06AM -0300, Fabio Estevam wrote:
> Add support for the ZII SCU 4 board, which has lots of switches and
> SFF ports.
> 
> Based on the work from Andrew Lunn.

Hi Fabio

This is not my version. It does not make use of sfp devices. The
properties listed here for SFP are proprietary to ZII kernel code, not
mainline. This file is not suitable for mainline.

	Andrew
