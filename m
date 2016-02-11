From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 11 Feb 2016 15:16:29 +0000
Subject: breaking DT compatibility
In-Reply-To: <20160211145158.GA8824@localhost.localdomain>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <56BB2D79.6090402@arm.com>
 <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
 <20160210143755.GE31506@lukather> <20160210163001.GG2632@leverpostej>
 <20160211100048.GK31506@lukather>
 <20160211145158.GA8824@localhost.localdomain>
Message-ID: <56BCA5CD.3080008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/02/16 14:51, Richard Cochran wrote:
> On Thu, Feb 11, 2016 at 11:00:48AM +0100, Maxime Ripard wrote:
>> None of our existing users ever complained.
> 
> Note to self:
> 
>    Avoid choosing this SoC for new projects.  The maintainers do not
>    care about the end users.

Now that's a bit harsh, I think.
Maxime is doing a great job for maintaining this admittedly not very
well architected and documented SoC "family" - in his spare time.

Also the actual end user experience is probably just fine (despite
broken DT compatibility), since on these storage-less boards the
distributions usually ship DT, firmware (U-Boot) and kernel bundled
together.
This does not qualify for breaking the DT deliberately, but we are about
to fix this as we speak.

Also my concern was just that I wanted to move away from this being the
only way of running Linux on those boards.

We may think about collecting DTBs and firmware for those boards in a
central place without direct connection to a certain Linux version or
distribution. This would make the whole idea more visible and would make
compatibility breaks more evident.

Cheers,
Andre.
