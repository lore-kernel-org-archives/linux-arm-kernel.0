From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 23 May 2018 00:56:38 +0300
Subject: v4.17-rc1: regressions on N900, N950
In-Reply-To: <20180522205824.GA24927@amd>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
Message-ID: <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 22, 2018 at 10:58:26PM +0200, Pavel Machek wrote:
> On Tue 2018-05-22 22:41:39, Aaro Koskinen wrote:
> > My device worked with v4.17-rc1 (haven't found time to test newer kernels),
> > but if you say the probe order is random then we must find some proper way
> > to express the dependency.
> 
> I started bisect, but.. that will probably not be useful.
> 
> If your device works ok in v4.17-rc1, it probably works in newer -rcs,
> too.

Actually, my statement may be bogus... Now I tried again with -rc1
(and also -rc6) and it fails... But v4.16 works.

> Thanks for the ordering hint, I'll try to figure out what is going on
> there.

My bisection pointed to 6fa7324ac5489ad43c4b6351355b869bc5458bef which
doesn't seem to make any sense...?! So maybe there really is something
random stuff going on? :-(

A.
