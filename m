From: bp@alien8.de (Borislav Petkov)
Date: Fri, 20 Mar 2015 17:57:46 +0100
Subject: [PATCH 31/35 linux-next] EDAC: constify of_device_id array
In-Reply-To: <1426535685-25996-10-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-10-git-send-email-fabf@skynet.be>
Message-ID: <20150320165746.GJ17058@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 08:54:41PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/edac/highbank_mc_edac.c | 2 +-
>  drivers/edac/mpc85xx_edac.c     | 4 ++--
>  drivers/edac/ppc4xx_edac.c      | 2 +-
>  drivers/edac/synopsys_edac.c    | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
