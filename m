From: philippe.retornaz@epfl.ch (Philippe =?iso-8859-15?q?R=E9tornaz?=)
Date: Wed, 27 Jul 2011 10:28:09 +0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
	codec
In-Reply-To: <4E1711EA.5070209@televic.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<201107081611.25998.philippe.retornaz@epfl.ch>
	<4E1711EA.5070209@televic.com>
Message-ID: <201107271028.09928.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Le vendredi 8 juillet 2011 16:19:22, Lambrecht J?rgen a ?crit :
> indeed, doesn't work at all. I know it used to work on 2.6.34.
> We also have a fsl linux 2.6.22 were it works.
> I must say: when i use aplay to play a mono file, then there is no
> error, it just never ends, and no sound also.
> For a stereo file, it gives the error.
> Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono
> or stereo mp3, it allocates 3 DMA channels, but only frees one after the
> error.
> 

Did you made any progress on this ? 

Regards,

Philippe
