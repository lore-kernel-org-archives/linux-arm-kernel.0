From: w@1wt.eu (Willy Tarreau)
Date: Wed, 15 Jan 2014 09:56:28 +0100
Subject: [PATCH net-next 1/2] net: mvneta: mvneta_tx_done_gbe() cleanups
In-Reply-To: <5880b38afc5884f5ed57c26824cc37666bd60b99.1389742334.git.arno@natisbad.org>
References: <cover.1389742334.git.arno@natisbad.org>
 <5880b38afc5884f5ed57c26824cc37666bd60b99.1389742334.git.arno@natisbad.org>
Message-ID: <20140115085628.GG4605@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 12:45:49AM +0100, Arnaud Ebalard wrote:
> 
> mvneta_tx_done_gbe() return value and third parameter are no more
> used. This patch changes the function prototype and removes a useless
> variable where the function is called.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Reviewed-by: Willy Tarreau <w@1wt.eu>

Willy
