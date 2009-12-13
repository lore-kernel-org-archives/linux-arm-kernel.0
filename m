From: fanyefeng@gmail.com (Fred Fan)
Date: Sun, 13 Dec 2009 14:23:28 +0800
Subject: IOP341 hang up
In-Reply-To: <2f495dc80912122222j2272c7c6o88e37f44c38b3a16@mail.gmail.com>
References: <2f495dc80912120111i6e38d5a9udca69032269886e8@mail.gmail.com>
	<2f495dc80912122219g2dc3cfddm1020a9ba2dd0810@mail.gmail.com>
	<2f495dc80912122222j2272c7c6o88e37f44c38b3a16@mail.gmail.com>
Message-ID: <2f495dc80912122223k1abbbd8bkab3f14d746b9b50d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>    Hi All:
>        Our customer reports our system will hang up without any log
> information on IOP341 1.2GHz board. IOP341 800MHz is more stable than it.
> But both of  them will hang. After sytem hang up, the BDI2000 can not halt
> arm core. And NMI interrupt never response any more.
>      It seems xscale core has hang. We have done below test.
>      1) 800MHZ IOP341 , Linux-2.6.29.1   [Result] hang after runing  over
> one day
>      2) 1.2GHZ IOP341 Linux-2.6.29.1      [Result] hang after 30'
>      3) 800MHZ IOP341 , Linux-2.6.31      [Result] Not hang until now(about
> over 9 days.
>      4) 1.2GHZ IOP341 Linux-2.6.31         [Result] about one day.
>
> We have review errata of iop341 (September. 2008 version).
> Just found 2 case will make core hang for special cache operation.
> And found 2 case for cache locked.
>
>     Another question, do IOP341 can use trace buffer to check hange resean.
> Best Regards
> Fred
>
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091213/5a39556e/attachment.htm>
