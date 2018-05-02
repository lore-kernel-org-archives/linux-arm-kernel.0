From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 May 2018 08:36:39 +0200
Subject: [PATCH v8 12/12] ARM: shmobile: Convert file to use cntvoff
In-Reply-To: <20180501123131.7738-13-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-13-mylene.josserand@bootlin.com>
Message-ID: <20180502063639.qa7bzqxzrejd4kh2@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 02:31:31PM +0200, Myl?ne Josserand wrote:
> Now that a common function is available for CNTVOFF's
> initialization, let's convert shmobile-apmu code to use
> this function.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
