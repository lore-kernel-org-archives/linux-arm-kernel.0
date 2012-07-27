From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 27 Jul 2012 15:36:33 +0200
Subject: [PATCH 4/7] mfd: ab8500-core: Apply the AB8500 CODEC's
 compatible string to its MFD cell
In-Reply-To: <1343392734-11805-5-git-send-email-lee.jones@linaro.org>
References: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
 <1343392734-11805-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20120727133633.GQ16859@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, Jul 27, 2012 at 01:38:51PM +0100, Lee Jones wrote:
> Provide a compatible string for the AB8500 CODEC to aid in
> configuration property look-up from its associated Device Tree
> node.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c |    1 +
>  1 file changed, 1 insertion(+)
Applied as well.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
