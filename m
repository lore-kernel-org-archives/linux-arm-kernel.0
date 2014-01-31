From: balbi@ti.com (Felipe Balbi)
Date: Fri, 31 Jan 2014 09:19:55 -0600
Subject: [PATCH] usb: dwc3: keystone: switch to use runtime pm
In-Reply-To: <1391174426-13773-1-git-send-email-grygorii.strashko@ti.com>
References: <1391174426-13773-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140131151955.GB20736@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 31, 2014 at 03:20:26PM +0200, Grygorii Strashko wrote:
> The Keystone PM management layer has been implemented using PM bus for
> power management clocks. As result, most of Keystone drivers don't need
> to manage clocks directly. They just need to enable runtime PM and use it
> to handle their PM state and clocks.
> 
> Hence, remove clock management code and switch to use runtime PM.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

quite a few weeks back I sent a series enabling runtime pm for all glue
layers. I'll use that version instead, sorry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/53f35523/attachment.sig>
