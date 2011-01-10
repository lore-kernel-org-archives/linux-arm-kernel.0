From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 10 Jan 2011 11:34:09 -0600
Subject: [PATCH] Fix ep93xx-fb init/exit annotations
In-Reply-To: <4D2A4AFD.4050008@bluewatersys.com>
References: <4D2A4AFD.4050008@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764CD96B69E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sunday, January 09, 2011 4:56 PM, Ryan Mallon wrote:
>
> Fix section mismatch errors in the ep93xx-fb driver resulting from
> incorrect init/exit annotations.
>
> Reported-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

That fixed it.

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
