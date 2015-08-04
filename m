From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Aug 2015 13:30:59 -0500
Subject: [PATCH v5 40/46] usb: gadget: epautoconf: rework ep_matches()
 function
In-Reply-To: <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150804183059.GC9623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 04:00:52PM +0200, Robert Baldyga wrote:
> Rework ep_matches() function to make it shorter and more readable.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

this regresses at least mass storage. How did you test it ? I'll keep
all patches up to this one, please fix the problem, rebase on
testing/next and resend the remaining patches.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/640cca5b/attachment.sig>
