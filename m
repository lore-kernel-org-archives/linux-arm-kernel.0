From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 Oct 2015 17:48:36 +0100
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <20151002142809.GA13483@leoy-linaro>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel> <20150930173145.GG15635@sirena.org.uk>
 <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
 <20150930191818.GZ15635@sirena.org.uk>
 <CANMBJr6aU4wPO5HqP-Oh-ND7_DZXSH30ykNHyvDtUp3nQFG6sA@mail.gmail.com>
 <20151001031552.GC15675@leoy-linaro>
 <20151001102136.GC12635@sirena.org.uk>
 <20151002142809.GA13483@leoy-linaro>
Message-ID: <20151002164836.GS12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 10:28:09PM +0800, Leo Yan wrote:
> On Thu, Oct 01, 2015 at 11:21:36AM +0100, Mark Brown wrote:

> > It seems sensible to get the DT bits for functionality that is already
> > supported on the driver side upstream, that way we get the maximum
> > functionality available as soon as possible and even if other bits get
> > problems in review users can take advantage of things that are OK.

> Okay, i will prepare patches for enabling CPUIdle ASAP.

Excellent, thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/c96700e4/attachment.sig>
