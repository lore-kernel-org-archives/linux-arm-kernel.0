From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Nov 2016 22:30:54 +0100
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Add missing newline
In-Reply-To: <20161127211727.GB13318@lunn.ch>
References: <1480276484-5482-1-git-send-email-afaerber@suse.de>
 <20161127211727.GB13318@lunn.ch>
Message-ID: <e9336935-264e-5d1c-656e-a48f89d1b015@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 27.11.2016 um 22:17 schrieb Andrew Lunn:
> On Sun, Nov 27, 2016 at 08:54:44PM +0100, Andreas F?rber wrote:
>> Found while reviewing Marvell dsa bindings usage.
> 
> Hi Andreas
> 
> It is good practice to put the maintainer you expect to accept the
> patch on the To: line. You have at least two different maintainers on
> Cc: so it is currently ambiguous. And these lists can be high volume,
> so without a copy in the maintainers inbox, patches can be overlooked.

As a vf610 DT patch with LAKML in To I am expecting it to be handled by
Shawn or anyone from the NXP/ARM side.

>> Fixes: f283745b3caf ("arm: vf610: zii devel b: Add support for switch interrupts")
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
