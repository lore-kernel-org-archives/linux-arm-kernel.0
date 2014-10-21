From: dushistov@mail.ru (Evgeniy Dushistov)
Date: Tue, 21 Oct 2014 22:54:23 +0400
Subject: [PATCH] fix for certain sequnce of request_irq can cause irq storm
In-Reply-To: <20141021173700.207475d8@free-electrons.com>
References: <20140726155659.GA22977@fifteen> <20140726165620.GA29269@lunn.ch>
 <20140726171253.GA10370@fifteen>
 <20141021161551.127321bc@free-electrons.com>
 <20141021152034.GA26186@fifteen>
 <20141021173700.207475d8@free-electrons.com>
Message-ID: <20141021185423.GA2869@fifteen>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 05:37:00PM +0200, Thomas Petazzoni wrote:
> Ok. And are you interested in seeing the mv78xx0 support being kept in
> the mainline kernel for the foreseeable future?
> 

Yes

> Right, you probably have no other choice but keeping the original
> U-Boot. But that's fine, with appended DTB, you can use this old U-Boot
> and boot modern kernels.
> 
> But are you interested in helping doing this migration, but sending
> some patches, doing some testing and so on?
> 

Yes, I am interesting. I am rather busy right now, and will be busy
in the next a couple of months, but after that I can write code to use
Device Tree or test already existing patches.

-- 
/Evgeniy
