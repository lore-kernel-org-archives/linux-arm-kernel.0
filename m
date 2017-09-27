From: bp@alien8.de (Borislav Petkov)
Date: Wed, 27 Sep 2017 17:48:03 +0200
Subject: [PATCH v10 1/7] edac: thunderx: Remove suspend/resume support
In-Reply-To: <20170925123502.17289-2-jglauber@cavium.com>
References: <20170925123502.17289-1-jglauber@cavium.com>
 <20170925123502.17289-2-jglauber@cavium.com>
Message-ID: <20170927154803.imsz77pitsste6b5@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 02:34:56PM +0200, Jan Glauber wrote:
> The memory controller on ThunderX/OcteonTX systems does not
> support power management. Therefore remove the suspend/resume
> callbacks.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/edac/thunderx_edac.c | 25 -------------------------
>  1 file changed, 25 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
