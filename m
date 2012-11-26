From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Nov 2012 10:28:26 +0000
Subject: [GIT PULL 5/5] ARM: mvebu: changes for v3.8
In-Reply-To: <20121126102805.5337f7f5@skate>
References: <pull-1353733874-990435> <20121126091652.GA13866@quad.lixom.net>
 <20121126102805.5337f7f5@skate>
Message-ID: <201211261028.26334.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 November 2012, Thomas Petazzoni wrote:
> Right. The problem is that some of the last developments had many
> dependencies against the previous developments, from various branches.
> So I wasn't sure how to do this last developments, and I did merge the
> branches containing the previous developments that I needed.
> 
> I am really open to suggestions on how to improve my Git workflow to
> handle this better. It certainly wasn't my intention to have this
> "test-the-merge" thing appear publicly.
> 

One thing that Sascha Hauer first introduced was an extra branch that
has everything merged together to show how you want to handle
the conflicts. We'll then merge the individual branches and in the
end can check if there is any difference to what you had.

	Arnd
