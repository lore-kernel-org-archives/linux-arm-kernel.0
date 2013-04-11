From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 14:08:10 -0400
Subject: [PATCH v3 3/9] ARM: mvebu: Align the internal registers
 virtual base to support LPAE
In-Reply-To: <1365461538-30702-4-git-send-email-gregory.clement@free-electrons.com>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
 <1365461538-30702-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130411180810.GN28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:52:11AM +0200, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> In order to be able to support the LPAE, the internal registers
> virtual base must be aligned to 2MB. In LPAE section size is 2MB, in
> earlyprintk we map the internal registers and it must be section
> aligned.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/include/debug/mvebu.S      |    2 +-
>  arch/arm/mach-mvebu/armada-370-xp.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/soc

thx,

Jason.
