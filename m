From: j.sixt@viscovery.net (Johannes Sixt)
Date: Mon, 24 Jan 2011 08:21:09 +0100
Subject: cannot fetch arm git tree
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch>
	<20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
	<4D3997FE.5030109@vollmann.ch>
	<20110121145025.GS13235@n2100.arm.linux.org.uk>
Message-ID: <4D3D2865.4020408@viscovery.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 1/21/2011 15:50, schrieb Russell King - ARM Linux:
>  SetEnv GIT_PROJECT_ROOT /var/www/git
>  SetEnv GIT_HTTP_EXPORT_ALL
>  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
> 
> Great.  Deciding that it will be http://servername.example.com/git/ is
> really damned annoying as that's traditionally where gitweb lives,
> which requires a different script alias.
> ...
> I'm really not interested in working out how to bodge this into working
> along side the existing gitweb setup by adding lots of rewrite rules,...

It has been worked out for you already. It's just a single rule (although
a bit longish). Look for 'ScriptAliasMatch' in
http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html

-- Hannes
