From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 May 2013 11:16:24 +0100
Subject: [RFC 3/4] DRM: add OF support for Dove DRM driver
In-Reply-To: <20130518211846.0ef5a14b@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194502.102caa9e@armhf> <5197C650.9020802@gmail.com>
 <20130518211846.0ef5a14b@armhf>
Message-ID: <20130520101624.GV18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 09:18:46PM +0200, Jean-Francois Moine wrote:
> The general hardware code of both drivers is close enough for merging
> may be done starting from anyone. But the general layout is not:
> 
> - my driver is DT driven and has one card with 2 CTRC's and 2 connectors.
> 
> - Russell's is non-DT, so, with some extra code I am not aware of, with
>   any number of cards each one with one CRTC and one connector (no, I

Utter shit, and I've told you before.  I'm not going to repeat it again,
and I warned you that we would have a falling out.  As you seem to be
immune to my comments provided in a sane manner, I'm now just going to
ignore you in the future because you're clearly not bothering to read
anything I'm telling you.  That makes further discussion with you utterly
pointless.

>   tried it, you cannot clone a connector of one card to the connector
>   of another card).
> 
> So, for me, merging means enhance my code from Russell's, but I will
> not go to a non-DT kernel.

You seem to see DT setups vs non-DT setups as two entirely separate things.
They are not.  We have plenty of drivers which work in both setups just
fine.

So really all of your points above are utter trash to me - really.

As to illustrate the point, my TDA19988 backend is now _just_ a slave
encoder backend, it has nothing TDA19988 specific, nor does it have
anything cubox specific there; the cubox specific part has been moved
up into dove_drv.c as pure data, and that data can be constructed
either from platform data or from OF properties parsed by dove_drv.c.

But why did I just bother to type that.  You're just going to ignore it
and keep repeating your same old claptrap.
