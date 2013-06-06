From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jun 2013 14:10:42 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <CAPweEDzYLDzh_-OWU61dtVhajZ40QpQgZKHFYDsh3FgF=r9_ag@mail.gmail.com>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron>
 <CAPweEDzYLDzh_-OWU61dtVhajZ40QpQgZKHFYDsh3FgF=r9_ag@mail.gmail.com>
Message-ID: <20130606131042.GN18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 06, 2013 at 01:24:57PM +0100, luke.leighton wrote:
> On Thu, Jun 6, 2013 at 1:01 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 
> > I don't see any other solution here than moving all the Allwinner code to
> > DT (as it has been suggested in this thread several times already), as
> > this is the only hardware description method supported by ARM Linux.
> 
>  i repeat again: please state, explicitly and unequivocably that you -
> linux kernel developers - are happy that the reach of linux and
> gnu/linux OSes is dramatically reduced due to this intransigent
> position.

If companies are going to go off and invent the square wheel, and that
makes *them* suffer the loss of being able to merge back into the
mainline kernel, thereby making *their* job of moving forward with
their kernel versions much harder, then yes, we *are* happy.

Companies will always do idiotic things; it's *them* and their users
who have to live with the results of that bad decision making process.

Eventually, the pain of being outside the mainline kernel will become
too great, especially if their users demand things like kernel upgrades
from them.  Eventually, they will change.

And no, this isn't an intransigent position.  This is reality given
that ARM already has way too much code in the Linux kernel and we're
trying to reduce that through the use of technologies like DT.  The
last thing we need right now is for another "DT" like implementation
to come along which is only used on a minority of platforms - even if
the platform it is used on is successful.

The way this works is this:
- you either go with the policies which are set, or
- you change the policy as a whole because you have a technically
  superior solution

What that means in this case is either you adopt DT, or you convince
everyone that DT isn't the solution, but your solution is, and we adopt
your solution for *everything* instead.

If neither of those are possible, then that's really not our problem,
and it's not _us_ who are being "intransigent".
