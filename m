From: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 22 Jan 2013 13:43:54 -0600
Subject: [PATCH] crypto: fix FTBFS with ARM SHA1-asm and THUMB2_KERNEL
In-Reply-To: <20130122095021.89432qdbeu32a4sg@www.dalek.fi>
References: <1358787763-1226-1-git-send-email-matt@genesi-usa.com>
 <alpine.LFD.2.02.1301211739470.6300@xanadu.home>
 <CAKGA1bkQ9e8gmSPz_4csJWjEOKj3ZVqSLijSTRWxgDSaZoYqCA@mail.gmail.com>
 <20130122094614.79031aq5ddrgr2zo@www.dalek.fi>
 <20130122095021.89432qdbeu32a4sg@www.dalek.fi>
Message-ID: <CAKGA1bmJwb94h0SVNW7WZkSYAPWeAUpm86D+SsvnOJ5NSNbe_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 1:50 AM, Jussi Kivilinna
<jussi.kivilinna@mbnet.fi> wrote:
>
>> There is 'tcrypt' module in crypto/ for quick benchmarking. 'modprobe
>> tcrypt mode=500 sec=1' tests AES in various cipher-modes, using different
>> buffer sizes and outputs results to kernel log.
>>
>
> Actually mode=200 might be better, as mode=500 is for asynchronous
> implementations and might use hardware crypto if such device/module is
> available.

Okeydokey I'll start running some tests..

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
