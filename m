From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Mar 2016 00:08:35 +0000
Subject: Who is going to merge it [Was: Re: [PATCH v14 0/17] Add Analogix
 Core Display Port Driver]
In-Reply-To: <56F1DB27.4040001@samsung.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
 <1919945.Y1tg0YzXlm@diego> <56F1CAEB.3080701@samsung.com>
 <8949624.HmxDpZAlt2@diego> <56F1D0AD.8030905@samsung.com>
 <20160322233906.GP19428@n2100.arm.linux.org.uk>
 <56F1DB27.4040001@samsung.com>
Message-ID: <20160323000835.GQ19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 08:54:15AM +0900, Inki Dae wrote:
> 

Please wrap your long lines.

> 
> 2016? 03? 23? 08:39? Russell King - ARM Linux ?(?) ? ?:
> > On Wed, Mar 23, 2016 at 08:09:33AM +0900, Inki Dae wrote:
> >> In this case, someone else may send an email again like you "who is going to merge?"
> >> That would be why we need a maintainer.
> >>
> >> drm panel is already managed well by Thierry Reding without such confusion. 
> > 
> > You don't need a maintainer for every subdirectory just because it's
> > a subdirectory...
> > 
> > Sometimes, having too many maintainers adds beaurocracy which becomes
> 
> Yes, but... if there is no someone who is responsible for maintainership,
> then we would receive such emails like Heiko sent "who is going to merge" 
> I don't also want adding many maintainers unnecessary but drm bridge -
> although the framework is a thin and small - is used *over the ARM SoC*
> so that many confusions may happen for upstream.

Just because someone asks doesn't mean someone needs to be appointed.
Maybe the question that should be asked instead is whether the original
author is willing to maintain their driver.

> So although it's small framework or just subdirectory, we would need
> someone who can manage the framework to avoid further confusion if
> necessary.

So maybe it just doesn't need a maintainer, and maybe those the owner
of the bridge driver should be responsible for choosing the tree which
it's merged through along with updates.  That's how dw-hdmi has been
managed on the whole.

It also means that the bridge driver maintainer is able to test changes
to the bridge driver, rather than having some over-arching bridge
subdirectory maintainer who doesn't have a clue whether the changes
work on the hardware.

IMHO, having bridge driver authors/maintainers look after their own
code has many advantages.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
