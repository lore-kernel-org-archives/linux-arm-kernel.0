From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Oct 2016 17:29:31 +0200
Subject: [PATCH] ARM/orion/gpio: Replace three seq_printf() calls by
 seq_puts() in orion_gpio_dbg_show()
In-Reply-To: <92ba3c30-386a-bb86-623d-0917cd9e61a2@users.sourceforge.net>
References: <92ba3c30-386a-bb86-623d-0917cd9e61a2@users.sourceforge.net>
Message-ID: <20161016152931.GA14097@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 16, 2016 at 12:38:26PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 16 Oct 2016 12:30:48 +0200
> 
> Strings which did not contain data format specifications should be put
> into a sequence. Thus use the corresponding function "seq_puts".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
