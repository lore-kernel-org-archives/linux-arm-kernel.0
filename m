From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Jul 2012 11:33:12 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <50069006.8050301@linaro.org>
References: <20120717130650.GB27595@sirena.org.uk> <500568D9.10805@linaro.org>
 <20120717133550.GC4477@opensource.wolfsonmicro.com>
 <50057058.2060002@linaro.org>
 <20120717142222.GE4477@opensource.wolfsonmicro.com>
 <50057C1A.80606@linaro.org>
 <20120717152001.GF4477@opensource.wolfsonmicro.com>
 <20120718053341.GA4009@S2100-06.ap.freescale.net>
 <20120718095937.GB22739@opensource.wolfsonmicro.com>
 <50069006.8050301@linaro.org>
Message-ID: <20120718103311.GG22739@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 11:29:26AM +0100, Lee Jones wrote:
> On 18/07/12 10:59, Mark Brown wrote:

> >It's not the using device tree bit that creates concern for me here,
> >it's the fact that the board and silicon aren't being separated.

> What's the difference?

> >+- db8500.dtsi       // silicon
> >\	
> > +-- snowball.dts    // board

I have glanced at some of this stuff in the past, thanks.  Now think how
that's working for people when they put the configuration for the
silicon in the same DT node as the configuration for the board...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/7dd4a279/attachment-0001.sig>
