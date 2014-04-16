From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Apr 2014 11:16:19 -0500
Subject: [PATCH 2/2] ARM: dts: omap5: Add dr_mode for dwc3
In-Reply-To: <52580F34.8030809@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <1381402195-29257-2-git-send-email-kishon@ti.com>
 <52580F34.8030809@ti.com>
Message-ID: <20140416161619.GH28035@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 05:46:12PM +0300, Roger Quadros wrote:
> Hi,
> 
> On 10/10/2013 01:49 PM, Kishon Vijay Abraham I wrote:
> > From: George Cherian <george.cherian@ti.com>
> > 
> > Added dr_mode property in dwc3 and set its default mode to device.
> 
> If there is a specific reason why this is not set to "otg", we need
> to explain it here.
> 
> AFAIK the port is meant to be used as OTG port.

we still don't have the workaround for dual role ports, I've been
working on it but still need to retest and make sure it's working fine
before merging upstream.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/043d5888/attachment.sig>
