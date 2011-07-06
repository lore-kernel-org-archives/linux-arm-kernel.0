From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 13:12:01 +0200
Subject: Please submit platform trees for inclusion in arm-soc.git v3.1
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D91AB83@dbde02.ent.ti.com>
References: <201107012018.14619.arnd@arndb.de>
	<B85A65D85D7EB246BE421B3FB0FBB593024D91AB83@dbde02.ent.ti.com>
Message-ID: <201107061312.01852.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Nori, Sekhar wrote:
> On Fri, Jul 01, 2011 at 23:48:14, Arnd Bergmann wrote:
> 
> > * If you currently merge your patches upstream through RMK's tree,
> >   you can keep doing so.
> 
> We currently send DaVinci patches upstream through Russell.
> This makes it look like the change applies only to those
> maintainers who were sending patches to Linus directly.
> 
> I want to make sure I read this correctly and should continue
> sending patches upstream through Russell?

You are welcome to submit patches to the arm-soc tree instead of
Russell's if you prefer to do so, either way is fine with me
at least.

The arm-soc tree was introduced mostly to reorganize the upstream
merge process for those platforms that directly send patches to
Linus, but we can also do it for everyone else.

We probably still need to try out a few things and see how it goes.
Russell also has write access to the arm-soc tree, so one of the
possible models is that you send the patches to him, but he adds
them to the arm-soc tree rather than the arm-linux one.

Russell, do you have a preference? If you want to stop merging
subarch trees into linux-arm.git, we can do that in arm-soc.git.
The idea behind my suggestion to keep using your tree was to not
change too many things at once, and we can always revisit this
question.

	Arnd
