From: philippe.retornaz@epfl.ch (Philippe =?utf-8?q?R=C3=A9tornaz?=)
Date: Tue, 20 Sep 2011 13:39:02 +0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
	codec
In-Reply-To: <CAPPnRU2LyJdHfA9W2porz_mWNo0fxAD+RSxrViNSK0Auinwpaw@mail.gmail.com>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
	<201107271028.09928.philippe.retornaz@epfl.ch>
	<CAPPnRU2LyJdHfA9W2porz_mWNo0fxAD+RSxrViNSK0Auinwpaw@mail.gmail.com>
Message-ID: <201109201339.02402.philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 29 juillet 2011 21:14:47, J?rgen Lambrecht a ?crit :
> 2011/7/27 Philippe R?tornaz <philippe.retornaz@epfl.ch>:
> > Hi
> > 
> > Le vendredi 8 juillet 2011 16:19:22, Lambrecht J?rgen a ?crit :
> >> indeed, doesn't work at all. I know it used to work on 2.6.34.
> >> We also have a fsl linux 2.6.22 were it works.
> >> I must say: when i use aplay to play a mono file, then there is no
> >> error, it just never ends, and no sound also.
> >> For a stereo file, it gives the error.
> >> Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono
> >> or stereo mp3, it allocates 3 DMA channels, but only frees one after the
> >> error.
> > 
> > Did you made any progress on this ?
> 
> Yes. Sascha fixed it, and will commit it.
> Regards,
> J?rgen

Do you know if there is any public git tree containing this code ? 

Regards,

Philippe
