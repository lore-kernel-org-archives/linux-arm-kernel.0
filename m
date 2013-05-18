From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 18 May 2013 21:18:46 +0200
Subject: [RFC 3/4] DRM: add OF support for Dove DRM driver
In-Reply-To: <5197C650.9020802@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194502.102caa9e@armhf> <5197C650.9020802@gmail.com>
Message-ID: <20130518211846.0ef5a14b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 May 2013 20:20:00 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> I put nothing to garbage. _You_ also agreed to merge with rmk's driver!
> We can now put in all features we implemented differently
> _step-by-step_.
> 
> Merging the drivers starts with adding support for DT - that is what
> I provided. You know the HW better than me, why don't you start picking
> features from your driver and add them in rmk's driver?

The general hardware code of both drivers is close enough for merging
may be done starting from anyone. But the general layout is not:

- my driver is DT driven and has one card with 2 CTRC's and 2 connectors.

- Russell's is non-DT, so, with some extra code I am not aware of, with
  any number of cards each one with one CRTC and one connector (no, I
  tried it, you cannot clone a connector of one card to the connector
  of another card).

So, for me, merging means enhance my code from Russell's, but I will
not go to a non-DT kernel.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
