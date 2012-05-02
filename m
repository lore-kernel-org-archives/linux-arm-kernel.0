From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 May 2012 12:47:32 +0000
Subject: Request for inclusion of ep93xx tree in linux-next
In-Reply-To: <4FA0D48F.2090800@gmail.com>
References: <4F9F16A9.9090108@gmail.com> <201205010836.28365.arnd@arndb.de>
 <4FA0D48F.2090800@gmail.com>
Message-ID: <201205021247.33220.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2012, Ryan Mallon wrote:
> Thanks for the tip. I leave the branches as is for the moment. If I end
> up adding any additional branches to my tree, then I will look at
> creating an ep93xx-for-next branch then. In this case, should the
> for-next branch just be a regular merge of all the other branches I
> have?

Yes. In the arm-soc tree I usually just merge all changes on top
of the for-next branch, and occasionally clean it up, starting over
with a fresh -rc release and pulling the other branches in, then
use git-diff to make sure the contents are identical to what they
were before.

> How do I make it verifiable that everything from the other
> branches has been being tested in the for-next branch?

I'm not sure I understand the question. Maybe you are looking
for 'git branch --no-merged for-next' That command will show
all local branches that are not merged into the for-next branch.

	Arnd
