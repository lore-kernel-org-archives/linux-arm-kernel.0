From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 13 Sep 2010 10:24:31 -0700
Subject: Remove unused default configurations
In-Reply-To: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
Message-ID: <1284398671.4003.4.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-09-13 at 16:13 +0100, Vincent Sanders wrote:
> Several default configurations have failed to build for the entire
> 2.6.36 cycle. There are several causes to these faliures. The exact
> issues can be tracked on http://armlinux.simtec.co.uk/kautobuild/
> 
> Obviously the maintainers are not using these default configurations
> because if they were they would have fixed the build issues by now.
> 
> As Linus has made it very clear the number of default configurations
> must be reduced as much as possible I have come up with the following
> series which will remove these nine unused configurations. This will
> reduce our build coverage by ten machines as all but one are a single
> config per machine.

I can't speak for anyone else, but I would prefer to see fixes for the
build issues. ARM has way too many build issues.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
