From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Sep 2014 14:36:12 +0200
Subject: [linux-sunxi] Re: [PATCH 3/6] ARM: dts: sunxi: Add Allwinner
 A80 dtsi
In-Reply-To: <CAGb2v64yGmdLeWmA=+nxD85DbQf_xxUNx3n3oedFZi51uc50+w@mail.gmail.com>
References: <1411311493-24344-1-git-send-email-wens@csie.org>
 <1411311493-24344-4-git-send-email-wens@csie.org>
 <20140924063738.GQ15315@lukather>
 <CAGb2v64voZpK_82wtkErRowR0vjEUALNUwvCx_sd8Q5wb4Hq-g@mail.gmail.com>
 <54227038.2020805@free-electrons.com>
 <CAGb2v64yGmdLeWmA=+nxD85DbQf_xxUNx3n3oedFZi51uc50+w@mail.gmail.com>
Message-ID: <5422BABC.7020906@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,


> 
> Thanks for the tip. Before I send v2, I do have a question. I'm using
> 
>     ranges = <0 0 0 0x20000000>;
> 
> in the clocks and soc node to avoid having to use 64bit values for all
> addresses and sizes. Would this be undesirable, even bad practice maybe?

We did something like that for all the internal registers too as they are all
under 4GB. In our case the use of a range really makes sens because the hardware
addresses were configurable. You don't have such requirement so I can't say if
it is a bad practice. From my point of view it seems sensible but I am not an
DT expert.


Gr?gory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
