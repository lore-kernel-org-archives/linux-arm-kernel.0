From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 19 Jun 2013 12:00:09 -0700
Subject: [PATCH] dmaengine: shdma: fix a build failure on platforms with
 no DMA support
In-Reply-To: <20130531024438.GB32564@verge.net.au>
References: <Pine.LNX.4.64.1305301650290.29171@axis700.grange>
 <51A77CF1.7040105@ti.com> <20130531024438.GB32564@verge.net.au>
Message-ID: <CAGa+x8413povhYWx+BSj=TdzQDAuYFXmjF4A2kXvQt+=n+380w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 7:44 PM, Simon Horman <horms@verge.net.au> wrote:

[...]

> thanks for this. I will wait for a refresh (as we discussed earlier today).
> Can I confirm that this is a fix for v3.10? If so, could ou note
> that when you post your revised patch?

Any progress on this patch?

The SH-mobile defconfigs are still all failing in linux-next.

Kevin
