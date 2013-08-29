From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 29 Aug 2013 11:27:01 +0200
Subject: [PATCH 0/2] ARM: Dove: Add audio to the DT
In-Reply-To: <20130828164829.14256ce2@skate>
References: <20130828113438.0a77fd54@armhf>
	<20130828164829.14256ce2@skate>
Message-ID: <20130829112701.3bd32fa0@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Aug 2013 16:48:29 +0200
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> On Wed, 28 Aug 2013 11:34:38 +0200, Jean-Francois Moine wrote:
> > This patch series adds audio DT to the Dove boards and activates the
> > Cubox audio device.
> > 
> > Full audio in the Cubox will work when the DT extension of the generic
> > simple audio card will be complete.  
> 
> What is the status of this generic simple audio card effort? I've seen
> the patch you had posted at https://lkml.org/lkml/2013/7/20/128 and the
> following discussion. Has anyone picked up the work of Kuninori
> Morimoto?

Hi Thomas,

I don't feel able yet to enter the ALSA internals.
Otherwise, there is this message from Lars:

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/064951.html

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
