From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2016 12:40:23 -0800
Subject: [PATCH] dts: sun8i-h3: correct UART3 pin definitions
In-Reply-To: <20161206142710.6450-1-jorik@kippendief.biz>
References: <20161206142710.6450-1-jorik@kippendief.biz>
Message-ID: <20161207204023.GB11699@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:27:10PM +0100, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> In a previous commit, I made a copy/paste error in the pinmux
> definitions of UART3: PG{13,14} instead of PA{13,14}. This commit takes
> care of that. I have tested this commit on Orange Pi PC and Orange Pi
> Plus, and it works for these boards.
> 
> Fixes: e3d11d3c45c5 ("dts: sun8i-h3: add pinmux definitions for
> UART2-3")
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

Applied to fixes. Thanks.


-Olof
