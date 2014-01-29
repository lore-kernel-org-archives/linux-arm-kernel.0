From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 29 Jan 2014 21:15:54 +0100
Subject: [PATCH v5 16/20] ARM: kirkwood: Add RSTOUT 'reg' entry to
 devicetree
In-Reply-To: <1390836440-12744-17-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-17-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140129201554.GJ10864@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 12:27:16PM -0300, Ezequiel Garcia wrote:
> In order to support multiplatform builds the watchdog devicetree binding
> was modified and now the 'reg' property is specified to need two
> entries. This commit adds the second entry as-per the new specification.
> 
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Ezequiel

I tested on Kirkwood, using the standard watchdog test cases. Works
great.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew
