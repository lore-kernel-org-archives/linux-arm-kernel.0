From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Jan 2014 12:08:40 -0800
Subject: [PATCH 1/3] ARM: bcm2835: Fix grammar in help message
In-Reply-To: <1388112192-4762-1-git-send-email-swarren@wwwdotorg.org>
References: <1388112192-4762-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140102200840.GD19720@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 07:43:09PM -0700, Stephen Warren wrote:
> From: Stefan Weil <sw@weilnetz.de>
> 
> Replace "is use" by "is used" and remove a comma.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> Since I only have 3 patches for bcm2835 this kernel cycle, and they'll
> likely go into different branches, I'm just re-sending them for direct
> application. These patches are already in linux-next, but since there
> are no linux-next being built at the moment, I've reset bcm2835's
> for-next to remove them, so there will be no conflict.
> 
> I imagine this would go into a "soc" branch in arm-soc.

Applied 1-3 (in next/fixes-non-critical, next/dt and next/boards respectively)


-Olof
