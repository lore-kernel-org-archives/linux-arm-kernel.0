From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 17:43:21 +0000
Subject: [PATCH 1/2] drm: Improve drm_of_component_probe() to correctly
 handle ports and remote ports.
In-Reply-To: <CAPj87rP_qPk0dKhLQDpFAsAqL2LxG=_5n+0KMRW=qEih4mBTJA@mail.gmail.com>
References: <1447685093-26129-1-git-send-email-Liviu.Dudau@arm.com>
 <1447685093-26129-2-git-send-email-Liviu.Dudau@arm.com>
 <20151116162241.GN8644@n2100.arm.linux.org.uk>
 <20151116164907.GA4158@e106497-lin.cambridge.arm.com>
 <20151116172248.GP8644@n2100.arm.linux.org.uk>
 <CAPj87rP_qPk0dKhLQDpFAsAqL2LxG=_5n+0KMRW=qEih4mBTJA@mail.gmail.com>
Message-ID: <20151116174321.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 05:32:05PM +0000, Daniel Stone wrote:
> On 16 November 2015 at 17:22, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Please sensibly wrap your messages.  Your lines are longer than 80
> > characters which makes it exceedingly difficult for some people to reply
> > to your very very very very very very very very very very very very
> > very very very very very very very very very very very very very very
> > very very very very very very very very very very very very very very
> > very very very very very very very very very very very very very very
> > very very very very very very very very very very very very very very
> > very very very very very very long lines without first reformatting
> > them manually - and why should they bother to reply if they have that
> > kind of additional work?  Thanks.
> 
> His lines are wrapped mostly at 80, but sometimes at 86, characters.
> You should probably look into fixing your MUA.

No.

Standard net etiquette is that email should be wrapped around 72
characters to give space for reply indentation to remain readable
on an 80 column screen. Most of my email replies are written on an
80 column screen.

Wrapping at 80+ characters is against proper net etiquette.

Same applies to GIT commits: wrap at around 72 characters to allow
them to be readable on an 80 column display.  Linus will hate you
if you don't.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
