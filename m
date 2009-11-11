From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Nov 2009 15:43:37 +0100
Subject: Patches for mxcmmc.c
In-Reply-To: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
References: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
Message-ID: <20091111144337.GK14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2009 at 06:13:33PM +0100, Daniel Mack wrote:
> Here are three update patches for the mxc mmc driver to bring it closer
> to a working SDIO implementation.
> 
> (There is one more pending which modifies the way the buffers' busy
>  flags are interpreted, but we're not yet sure whether this one does
>  the right thing, so I'm not yet posting it now.)
> 
> I'm not sure whether the problems we're having here are due to the
> fact that DMA does not yet work on MX3. Hence, I would appreciate if
> anyone with access to an MX2 board could try these patches and see
> if the hardware can talk to SDIO connected peripherals (preferably
> a Libertas Wifi solution, but trying anything else might also give
> a hint).

Was anyone with a MX2 based board able to help testing this? It would be
very important for us to know whether SDIO cards work with DMA.

Thanks,
Daniel
