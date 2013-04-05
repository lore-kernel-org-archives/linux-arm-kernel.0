From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Apr 2013 10:41:59 +0100
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <20130328134808.GD16765@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.03.1304022258430.1171@syhkavp.arg>
 <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
Message-ID: <20130405094159.GH17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right, you force my hand.  None of the stuff below should be public, but
you give me no choice now but to publically defend myself against your
allegations.

The reason that I haven't merged it is that:

1. At the beginning of December, when the TI situation looked very
   uncertain, I approached Linaro to see whether it was possible to
   sort out a relationship with them.  Linaro were enthusiastic.

2. It took weeks for anything to really happen - indeed, the first
   sign of any kind of idea for any work was first mentioned at the
   beginning of January, the day that Nicolas posted these patches
   for review.  The work was going to be to review these patches.

3. As that was going to be the subject of the work, and there was no
   arrangement in place, I actively avoided reviewing these changes.

4. Along with this came the provision that I was to attend two Linaro
   connects a year.

5. It turns out that this provision was made based on rumour and gossip
   about my medical situation concerning my eye, based on travel that I
   had done last year.  Rather than *talk* to me and find out what the
   real situation was, Linaro decided to have internal discussions about
   this, based on this rumour and gossip.

6. It took a week or more to sort out that situation, which should never
   have arrisen if people didn't gossip and rumour.

7. The work (2) has now been withdrawn, and I'm now being left with being
   told "we have problems working out what work to give you".

So at this point, I view any kind of relationship with Linaro as being a
extremely poor, and probably no longer worth persuing - not because of
any fault of mine, but a total wreckage of our relationship due to bad
management behaviour within Linaro based on rumour and gossip.

Hence, I have never gone back and reviewed the patches Nicolas is
referring to, because I've *NO* idea what so ever what's going on with
Linaro.  If they can't think of anything they want me to work on, and
this stuff is still outstanding then... well... what hope is there?

Now, I'm currently on holiday.  I'm going to be on holday until after
mid-April.  I'm not pulling anything until then.  I'm not applying anything
until then.  I'm not even reading this mailbox - and given current mail
rates at 300-400 messages per day, I will *not* be reading back over a
fortnights worth of email.

The only reason I'm trying to this is because Will Deacon pointed it out
to me via IRC.

So, in summary, this situation has been created by Linaro *themselves*
and it's all their problem.  They can sort it out if they want to be
cooperative and give me the work that they were originally proposing.
If not... I'm not sure where we go.

But all that I get from you is "you must pull this stuff anyway, whether
you've reviewed it or not".  Sorry, no.

On Thu, Apr 04, 2013 at 10:03:54PM -0400, Nicolas Pitre wrote:
> I want to deplore a situation that highlights a bottleneck with our 
> current upstreaming process on ARM affecting the MCPM patch series I'm 
> maintaining.
> 
> This patch series has been extensively reviewed.
> 
> 1st review cycle (10 Jan 2013):
> http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=208625
> 
> 2nd review cycle (24 Jan 2013):
> http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=212196
> 
> 3rd review cycle (29 Jan 2013):
> http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=213562
> 
> 4th review cycle (5 Feb 2013):
> http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=215477
> 
> The following people were involved in the discussion:
> 
>   Achin Gupta
>   Catalin Marinas
>   Dave Martin
>   Jon Medhurst
>   Joseph Lo
>   Lorenzo Pieralisi
>   Saeed Bishara
>   Santosh Shilimkar
>   Stephen Boyd
>   Rob Herring
>   Pawel Moll
>   Will Deacon
> 
> Resulting review comments were all addressed.  
> 
> So, a pull request for the v3.8 merge window was posted (6 Feb 2013):
> http://article.gmane.org/gmane.linux.ports.arm.kernel/216061
> 
> This, however, didn't get merged in time due to some miscommunication
> about non technical reasons.  I therefore won't expose those reasons 
> here.  Suffice to say that a merge window was missed.
> 
> Therefore, this was followed by another pull request for the v3.9 merge window (25 Mar 2013):
> http://article.gmane.org/gmane.linux.ports.arm.kernel/225873
> 
> Followed by a merge plan inquiry from Lorenzo (28 Mar 2013):
> http://article.gmane.org/gmane.linux.ports.arm.kernel/227035
> 
> To end up with my ping (3 Apr 2013):
> http://article.gmane.org/gmane.linux.ports.arm.kernel/228209
> 
> Russell mentioned having issues with the mailing list traffic and pull
> request being buried.  He therefore suggested a special email alias
> to filter pull requests (22 Mar 2013):
> http://article.gmane.org/gmane.linux.ports.arm.kernel/225377
> 
> The last pull request used that alias, and the latest ping did use both 
> the pull alias as well as his regular email address.
> 
> We're approaching v3.9-rc6, and there is still no sign of this patch set 
> being headed for mainline yet.  The system is _not_ working if this 
> series is to miss yet another merge window.
> 
> On March 28th, Russell mentioned he'd be sporadically away for the 
> following two weeks, and suggested that the GIC patches go through the 
> ARM SoC tree:
> http://article.gmane.org/gmane.linux.ports.arm.kernel/227040
> 
> Given the lack of backup to pick up the load when Russell is unavailable 
> (seeing the next merge window approaching and still no response from my 
> latest pull request and its subsequent recalls), I'm questionning the 
> current process scalability. Therefore, at this point, I'm suggesting 
> that the MCPM series be merged in the ARM SoC tree as well, as a backup 
> solution.
> 
> After all, this series is a prerequisite for more patches about platform 
> specific patches meant for the ARM SoC tree but which currently are 
> still waiting.  Having the prerequisite in the ARM SOC tree will allow 
> for those patches to be exposed earlier.
> 
> 
> Nicolas
