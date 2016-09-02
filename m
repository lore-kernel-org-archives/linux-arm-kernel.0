From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Sep 2016 10:17:58 +0200
Subject: [PATCH v3 01/13] ARM: dts: lager: rename and reindex i2cexio
In-Reply-To: <20160830151819.GA1695@katana>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
 <1466567031-20381-2-git-send-email-horms+renesas@verge.net.au>
 <20160830151819.GA1695@katana>
Message-ID: <20160902081757.GB16669@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 05:29:08PM +0200, Wolfram Sang wrote:
> Hi Simon,
> 
> >  		serial0 = &scif0;
> >  		serial1 = &scifa1;
> > -		i2c8 = "i2cexio";
> > +		i2c10 = "i2cexio0";
> 
> Those should be pointers, i.e. "&i2cexio0;", here and in the rest of
> your series. Sorry for the broken template!

Thanks, got it.

> Did you have a chance to
> test my fix for the demuxer?

Sorry, not yet.
