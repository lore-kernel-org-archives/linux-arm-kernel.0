From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 30 Jul 2013 09:30:21 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778: add HPB-DMAC support
In-Reply-To: <51F6F0BF.2030004@cogentembedded.com>
References: <201307230218.01495.sergei.shtylyov@cogentembedded.com>
 <201307230222.04763.sergei.shtylyov@cogentembedded.com>
 <20130726001052.GA28912@verge.net.au>
 <87a9lacd6o.wl%kuninori.morimoto.gx@renesas.com>
 <51F6F0BF.2030004@cogentembedded.com>
Message-ID: <uzjt499eq.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> > Is this correct ?
> > And what is 0x0C port ?
> 
>     SDHI0 if you look into the table 16.7 of the R-Car M1A manual 1.00 for the 
> channels 21 thru 23.

Ahh... yes, indeed
sorry for my noise

> > I want 1 line for 1 channels on hpb_dmae_channels.
> > like this
> 
> > static const struct hpb_dmae_channel hpb_dmae_channels[] = {
> > 	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_TX), /* ch21 */
> > 	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_RX), /* ch22 */
> > }
> 
>     OK, done.

Thank you
