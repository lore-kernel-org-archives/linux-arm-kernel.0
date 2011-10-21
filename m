From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Oct 2011 19:33:52 +0100
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <2901028.94TxBXiCYq@wuerfel>
References: <4E97A601.1020005@gmail.com> <4EA055AF.4030207@gmail.com>
	<20111020185612.GD21648@n2100.arm.linux.org.uk>
	<2901028.94TxBXiCYq@wuerfel>
Message-ID: <20111021183352.GI21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 11:04:35PM +0200, Arnd Bergmann wrote:
> I'm not sure if I used the intended process to get at those branches.
> Since they are not published on ftp.arm.linux.org.uk as separate branches,
> I looked at the big merge changeset in the for-next branch and recreated
> the branches I needed, which feels like I'm doing something that wasn't
> your intention. Is there a better way?

The best way is to say "Hey, my work depends on X, Y, Z" and I'll see
what can be done to make them stable _and_ say whether they are ripe
for that yet (or, eg, whether they're waiting for peoples acks.)

It's actually what I documented a while ago at
http://www.arm.linux.org.uk/developer/git-arm.php
