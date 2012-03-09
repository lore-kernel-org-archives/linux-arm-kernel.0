From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 11:47:36 +0000
Subject: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for
 v3.4
In-Reply-To: <20120309003217.GB12083@atomide.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
 <87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
Message-ID: <20120309114731.GA3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 04:32:18PM -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [120308 09:37]:
> > Tony Lindgren <tony@atomide.com> writes:

> > Oh, that's because it depends on the regulator core changes that are in
> > Mark's regulator tree.  You need the for-next branch of :

> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

> > For this to compile correctly.

> > Sorry, I should've been more clear above about the build dependency.

> Hmm just checking.. Recently Mark replied to Peter:

...

> So can you guys please confirm that if is indeed an immutable
> commit to use as a base to merge in something?

Absolutely not, the for-next branch is rebuilt frequently especially
since it includes stuff sent to Linus and he complained about bugfixes
merged up into development code.  What is the actual dependency here?
The topic branches are more or less static, though some more than
others.

In general you should warn people if you've got a dependency on their
tree, it makes life easier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/1cadb9fb/attachment-0001.sig>
