From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jun 2014 21:15:11 +0200
Subject: [PATCH v2 0/2] Improve mvebu_get_soc_id
In-Reply-To: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140620191511.GB32533@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 04:35:51PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> The first use -ENODEV as return value instead of -1 as suggested by
> Arnd for the second patch.
> 
> The second patch allows to get the SoC Id and the revision without using
> the PCI register on Armada 38x.

Hi Gregory

I just tested on Kirkwood. No regression.

Once we get the compatible string worked out, i will post a Tested-by:

     Andrew
