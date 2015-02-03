From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 3 Feb 2015 17:39:50 +0100
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.20 (round 3)
In-Reply-To: <54D0EE90.1040708@lakedaemon.net>
References: <54D0ECF2.9050104@free-electrons.com>
 <54D0EE90.1040708@lakedaemon.net>
Message-ID: <20150203163950.GR4827@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 10:51:44AM -0500, Jason Cooper wrote:
> >are available in the git repository at:
> >
> >   ssh://git.infradead.org/srv/git/linux-mvebu.git tags/mvebu-dt-3.20-3
> 
> oops.  Please resend with the git:// url.  I tend to have two remotes for
> this sort of thing, 'mvebu' -> ssh://, and 'mvebu-pub' -> git://
> 
> Then, I just make sure I see 'mvebu-pub' in the middle of the request-pull
> command.

There's actually two different URLs you can set up for the remotes in
your git config: "url", for when you want to pull, and "pushURL", for
when you want to push.

That way, you just have a single remote, and everything just works,
avoiding mistakes like the above.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/d46bd69e/attachment.sig>
