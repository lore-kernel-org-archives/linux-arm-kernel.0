From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 22:50:28 +0200
Subject: [PATCH v2 2/9] arm: mvebu: Align the internal registers virtual
 base to support LPAE
In-Reply-To: <1365193444-13441-3-git-send-email-gregory.clement@free-electrons.com>
References: <1365193444-13441-1-git-send-email-gregory.clement@free-electrons.com>
 <1365193444-13441-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201304052250.28641.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> In order to be able to support he LPAE, the internal registers virtual
> base must be aligned to 2MB.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This is a surprising limitation. Can you extend the above text to go into more
detail where that alignment requirement comes from?

	Arnd
