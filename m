From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Wed, 20 Nov 2013 03:14:09 +0000
Subject: [PATCHv2 3/8] ARM: dts: Enables SAI ALSA SoC DAI device for
 Vybrid VF610 TOWER board.
In-Reply-To: <87bo1hk2i7.fsf@nbsps.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com>
 <87bo1hk2i7.fsf@nbsps.com>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828AD451@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This patch add and enable SAI device.
> >
> > arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/vf610-twr.dts
> > b/arch/arm/boot/dts/vf610-twr.dts index 1a58678..e4106dd 100644
> > --- a/arch/arm/boot/dts/vf610-twr.dts
> > +++ b/arch/arm/boot/dts/vf610-twr.dts
> >>> -57,6 +57,12 @@
> > 	status = "okay";
> > };
> 
> Should we put a comment here that a TWR-AUDIO-SGTL board is needed?  Or
> is this better in a menuconfig?  I guess TWR-AUDIO-SGTL is needed as this
> codec is not on the VF610-TWR main board?
> 

Yes, the SGTL5000 codec is not on the VF610-TWR main board, and needs an extra TWR-AUDIO-SGTL board.

IMO, puting this comment in the menuconfig is much better.


--
Best Regards,
Xiubo
