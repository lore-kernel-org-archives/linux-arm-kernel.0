From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Dec 2012 08:39:42 -0800
Subject: [GIT PULL 0/5] ARM: arm-soc: First batch of updates for 3.8
Message-ID: <20121212163942.GA16036@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the first set of pull requests for arm-soc for this merge window.

Unfortunately we seem to have quite a few of little nagging merge conflicts for
this release. There's been some bugfixes upstream that conflicted with cleanups
and refactorings, and there's been a lot of header file moves that resulted in
include-section conflicts.

I've documented my proposed resolution in each pull request, and as usual
I have also pushed up my resulting merge as <branch>-resolved, in case you want
to diff.

There's only one gotcha that I am aware of, and that is for the 'cleanup'
branch, where a build break will be introduced if you don't fixup a
function name rename/conflict that isn't detected by git since the new
code was added with the old name in one of the branches. Not a big deal
if you miss it, we'll submit a patch to fix it up in that case.

I've got more to come, but wanted to break it up in a couple of batches. More
details in each pull request.


Thanks!


-Olof
