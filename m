From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 23 Mar 2017 16:12:37 +0100
Subject: [PATCH] ARM: dts: at91: add envelope detector mux to the Axentia
 TSE-850
In-Reply-To: <1489789486-30985-1-git-send-email-peda@axentia.se>
References: <1489789486-30985-1-git-send-email-peda@axentia.se>
Message-ID: <20170323151237.u7vu63kxygxopq4b@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/2017 at 23:24:46 +0100, Peter Rosin wrote:
> The envelope detector can analyze 6 different signals, selectable with a
> mux controlled by three gpio pins.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
> 
> Hi!
> 
> This patch makes use of the mux subsystem and a couple of drivers
> available in linux-next since a week or two. The stuff this depends
> on has relevant acks, specifically on the DT bindings, so the bindings
> should be stable and not cause trouble for this patch. Which is why I
> thought I'd try to get this in for v4.12-rc1 along with that mux
> subsystem series.
> 
> Please consider applying.
> 
> Cheers,
> peda
> 
> arch/arm/boot/dts/at91-tse850-3.dts | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
