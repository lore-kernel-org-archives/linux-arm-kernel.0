From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Wed, 25 Jan 2012 16:45:40 +0100
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
 codec
In-Reply-To: <201107271028.09928.philippe.retornaz@epfl.ch>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
 <4E1711EA.5070209@televic.com> <201107271028.09928.philippe.retornaz@epfl.ch>
Message-ID: <2667396.yifGumf5nD@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> Le vendredi 8 juillet 2011 16:19:22, Lambrecht J?rgen a ?crit :
> > indeed, doesn't work at all. I know it used to work on 2.6.34.
> > We also have a fsl linux 2.6.22 were it works.
> > I must say: when i use aplay to play a mono file, then there is no
> > error, it just never ends, and no sound also.
> > For a stereo file, it gives the error.
> > Mark also that when I use madplay (v0.15.2) (or mp3play) to play a mono
> > or stereo mp3, it allocates 3 DMA channels, but only frees one after the
> > error.
> 
> Did you made any progress on this ?

I have a working sound support for the mx31moboard boards available here:
http://github.com/retornaz/linux/commits/moboard-sound

It's basically Sascha mc13783 codec driver (from his git tree) rebased on 3.2 
and some mx31moboad specific code.

I can playback & record sound on our board (2 channels at 16Khz) with the sdma.

Sascha, do you have any plan to upstream the mc13783 codec driver ? 

Thanks,

Philippe
