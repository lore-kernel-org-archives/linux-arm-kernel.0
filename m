From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 15 Oct 2015 17:31:16 +0200
Subject: [PATCH 3/3] ARM: at91/defconfig: update sama5 defconfig
In-Reply-To: <20151015132451.GD3421@piout.net>
References: <1444824684-24526-1-git-send-email-ludovic.desroches@atmel.com>
 <1444824684-24526-3-git-send-email-ludovic.desroches@atmel.com>
 <20151015132451.GD3421@piout.net>
Message-ID: <20151015153116.GE26893@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 03:24:51PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 14/10/2015 at 14:11:24 +0200, Ludovic Desroches wrote :
> > Add SAMA5D2 SoC plus Atmel flexcom and Atmel sdhci devices.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  arch/arm/configs/sama5_defconfig | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> It is probably worth updating the multi_v7_defconfig too (in a separate
> patch).
> 

Maybe I have to send a whole defconfig update . I mean when you do
savedefconfig, you have more changes. I won't send each one separately. I
have kept changes which were in relation with the stuff I had.

Or I can send a defconfig update from the savedefconfig and then add
sama5d2, flexcom and sdhci.

Ludovic
