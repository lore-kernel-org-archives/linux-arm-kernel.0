From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 3 Jun 2017 18:50:30 +0900
Subject: [PATCH v2] misc: atmel-ssc: Handle return value of
 clk_prepare_enable and clk_prepare
In-Reply-To: <3a6a9ccd68fe298ab33009eaaace85c5af73e1ea.1496381884.git.arvind.yadav.cs@gmail.com>
References: <3a6a9ccd68fe298ab33009eaaace85c5af73e1ea.1496381884.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170603095030.GA7439@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 11:09:02AM +0530, Arvind Yadav wrote:
> clk_prepare_enable() and clk_prepare() can fail here and
> we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/misc/atmel-ssc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

What changed from v1?  Always put that information below the --- line.

v3 please?
