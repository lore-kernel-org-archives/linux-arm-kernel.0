From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 28 Jan 2016 16:51:29 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56A9CE3D.4020906@redhat.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com>
Message-ID: <20160128165129.b9ab69d44aa7f32f4dbf5215@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan 2016 09:15:57 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> p.s.
> 
> Did I understand correctly that you are working on a kms (or fbdev) driver
> for the H3? A fellow Dutch hacker (Jelle van der Waa, added to the Cc) is
> looking into adding H3 video console support to upstream u-boot. If you
> already have a lit-up display with an upstream kernel it would be great
> if you could share that, even if it is still wip.

Hi Hans and Jelle,

I submitted a (second) patch mid-january:

	http://www.spinics.net/lists/dri-devel/msg98558.html

It has changed a bit since this time (towards simplification).
I was to submit a new patch, but the hardware cursor refuses to have
transparent pixels!
Otherwise, the TCON1 and DE2 are simple enough for the primary plane.
The problem is the HDMI driver...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
