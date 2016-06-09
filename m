From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 9 Jun 2016 16:52:35 +0100
Subject: [PATCH] ARM: orion: remove unreferenced board-d2net.c
In-Reply-To: <20160609161215.084e06f1@free-electrons.com>
References: <1465466656-30002-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160609133116.GH30205@lunn.ch> <20160609153935.44323b8e@free-electrons.com>
 <20160609141006.GK30205@lunn.ch> <20160609161215.084e06f1@free-electrons.com>
Message-ID: <d521ce93-f647-0c6f-89f5-aeffd82b87e1@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/16 15:12, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 9 Jun 2016 16:10:06 +0200, Andrew Lunn wrote:
> 
>>> That being said, this has been broken more than 2 years ago, and nobody
>>> noticed. Doesn't this mean that we could get rid of the support for
>>> this board entirely? :)  
>>
>> Well, all it means is the LEDs don't blink. If the disk was not
>> spinning, or the ethernet device missing, i would agree with you. But
>> somebody could be using this device and don't notice the difference
>> with the LEDs.

Surely DT can manage blinking LEDs??

> True. I'm probably trying to hard to clean up the dust :)
> 
> Thomas
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
