From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 5 Nov 2012 19:53:45 +0530
Subject: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
In-Reply-To: <20121105141442.GD4815@arwen.pp.htv.fi>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
 <20121105141442.GD4815@arwen.pp.htv.fi>
Message-ID: <5097CBF1.6060108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
>> -							dev->syscstate);
>> > -		}
> not sure if this will work. What about the first time you call reset() ?
> won't SYSC just contain the reset values ?
No actually the hwmod sets the value.
