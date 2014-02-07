From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 07 Feb 2014 18:34:26 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1391730137-14814-22-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
Message-ID: <52F51922.6030502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> Now that all the device tree support is in mach-mvebu, remove it from
> mach-kirkwood.
>
> Regenerate kirkwood_defconfig, removing all DT support, and a couple
> of other redundent options have been removed in the process.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

Hmm, I wonder what Ian thinks of removing this so quickly again...

Maybe let it rot for 1-2 kernel versions?

Sebastian
