From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Thu, 20 Sep 2012 07:45:39 +0300
Subject: [PATCH] mmc: mxs-mmc: implement broken-cd
In-Reply-To: <20120910135034.GD13076@S2101-09.ap.freescale.net>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120910060840.GT26709@S2101-09.ap.freescale.net>
 <504DBB10.9030702@bluegiga.com>
 <20120910135034.GD13076@S2101-09.ap.freescale.net>
Message-ID: <505A9F73.7090702@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/10/2012 04:50 PM, Shawn Guo wrote:
> On Mon, Sep 10, 2012 at 01:04:00PM +0300, Lauri Hintsala wrote:
>>>> @@ -187,6 +188,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>>>>   {
>>>>   	struct mxs_mmc_host *host = mmc_priv(mmc);
>>>>
>>>> +	if (host->broken_cd)
>>>> +		return -ENOSYS;
>>>> +

...

> But for this patch:
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Any chance to get this patch for 3.7? It makes possible to use the 
driver without a card detect signal.

Regards,
Lauri
