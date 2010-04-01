From: grfstrm@users.sourceforge.net (=?ISO-8859-1?Q?Anders_Grafstr=F6m?=)
Date: Thu, 01 Apr 2010 19:29:59 +0200
Subject: Memory corruption with 2.6.32.10, but not with 2.6.34-rc3
In-Reply-To: <20100401132156.GJ30807@buzzloop.caiaq.de>
References: <20100401132156.GJ30807@buzzloop.caiaq.de>
Message-ID: <4BB4D817.1050603@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:
> We would like to have a fix for this annoying bug in the stable series
> (especially 2.6.32.x) as well, but I don't have much ideas about where
> to search for it. Hence, I would appreciate if maintainers could think
> about any possible commits in the described time window which haven't
> reached stable. Does the description ring anyone's bell?
> 
> I can cherry-pick things if anyone pin-points something and run
> lont-time tests again. Any pointer appreciated.

You could try this one:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8e4971f2fb2380ce66196136e113d04196b80fcd
