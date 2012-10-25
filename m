From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 15:30:29 +0000
Subject: [PATCH 1/7] ARM: clps711x: convert to clockevents
In-Reply-To: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
References: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
Message-ID: <201210251530.29861.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012, Alexander Shiyan wrote:
> This patch converts CLPS711X-platform to use modern clockevent API.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied the entire series. There are a few things that you can do
to simplify the process so you don't have to remind us to pull in
patches you send:

* Use 'git format-patch --cover-letter' to create an introductory
email, and in that mail, ask us specifically to pull it into arm-soc
of that is the idea, or to just do a review for the first version.

* Send one patch to add yourself to the maintainers file. You are
the only person who is sending patches for clps711x at the moment,
and we don't have a formal maintainer besides you, so I think you
should do it officially.

* If possible, provide a git URL to pull from directly, and use
a signed tag to describe the series overall. Use "git request-pull"
to send the email asking for your changes to be pulled in.

The patches from this set are now in the clps711x/soc branch,
merged into the next/soc branch that will be sent in the 3.8
merge window and they are part of the for-next branch to get
testing in the linux-next kernel.

	Arnd
