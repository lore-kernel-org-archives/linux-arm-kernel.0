From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 10:50:38 +0900
Subject: [PATCH 3/3] ARM: dts: Add WM1811A audio CODEC to Arndale bindings
In-Reply-To: <20130702092507.GV27646@sirena.org.uk>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
 <1372714599-17588-3-git-send-email-broonie@kernel.org>
 <51D26360.2080708@linaro.org> <20130702092507.GV27646@sirena.org.uk>
Message-ID: <0deb01ce8810$3295b790$97c126b0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Tue, Jul 02, 2013 at 10:51:36AM +0530, Tushar Behera wrote:
> 
> > Arndale board also comes with two other audio codec boards - ALC5631Q
> > and AK4678. Different audio codec boards came with different shipments.
> 
> This is the default though and since they didn't bother providing any
> way of identifying the modules we just have to put them all in the
> device tree and hope that the individual CODEC drivers can do runtime
> identification (the WM1811A can but I don't know about the other two,
> nobody supported them upstream).

Basically, I agree with Mark Brown's opinion, at this moment would be better
if upstreamed WM1811A could be supported on Arndale and if further
supporting of two codecs is required, we could discuss again next time. And
they should be identified in the kernel at runtime.

- Kukjin
