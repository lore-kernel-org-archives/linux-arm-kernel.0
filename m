From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Wed, 24 Nov 2010 13:11:29 +0100
Subject: [PATCH 2/3] regulators: Update of ab8500 driver
In-Reply-To: <20101124104851.GA24970@rakim.wolfsonmicro.main>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1290536754-21775-3-git-send-email-bengt.g.jonsson@stericsson.com>
	<20101123183833.GB19212@rakim.wolfsonmicro.main>
	<4CECC555.8060408@stericsson.com>
	<20101124104851.GA24970@rakim.wolfsonmicro.main>
Message-ID: <4CED00F1.6050004@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-11-24 11:48, Mark Brown wrote:
> On Wed, Nov 24, 2010 at 08:57:09AM +0100, Bengt Jonsson wrote:
>
>> Removing the macros is just my suggestion. The disadvantage I see
>> with macros is that I need to read both the macro and the listing to
>> see what it really does. On the other hand, macros are probably more
>
> A line of comment at the top of the macro table would probably address
> that?
I will make sure to have a comment at the top.

Still, I would like to provide a patch which removes the macros just to 
show the difference. Then you can decide to drop it or propose another 
change.
