From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 16:25:17 +0200
Subject: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
In-Reply-To: <5097CBF1.6060108@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
 <20121105141442.GD4815@arwen.pp.htv.fi> <5097CBF1.6060108@ti.com>
Message-ID: <20121105142517.GG4815@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 05, 2012 at 07:53:45PM +0530, Shubhrajyoti wrote:
> On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
> >> -							dev->syscstate);
> >> > -		}
> > not sure if this will work. What about the first time you call reset() ?
> > won't SYSC just contain the reset values ?
> No actually the hwmod sets the value.

ahaaa, ok good. Let's get an Ack from Benoit, then.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/43559f90/attachment.sig>
