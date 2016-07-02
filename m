From: carlo@caione.org (Carlo Caione)
Date: Sat, 2 Jul 2016 10:27:21 +0200
Subject: [PATCH v2 4/6] nvmem: amlogic: Add Amlogic Meson EFUSE driver
In-Reply-To: <57763F42.3070106@linaro.org>
References: <1467203656-14381-1-git-send-email-carlo@caione.org>
 <1467203656-14381-5-git-send-email-carlo@caione.org>
 <57763F42.3070106@linaro.org>
Message-ID: <20160702082721.GA16826@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/16 11:00, Srinivas Kandagatla wrote:
> 
> 
> On 29/06/16 13:34, Carlo Caione wrote:
> >From: Carlo Caione <carlo@endlessm.com>
> >
> >Add Amlogic EFUSE driver to access hardware data like ethernet address,
> >serial number or IDs.
> >
> >Signed-off-by: Carlo Caione <carlo@endlessm.com>
> 
> Patch looks good to me,
> 
> Looks like there are some dependencies to this patch w.r.t sm_calls, it
> would be easy to take this series from single tree.
> 
> Just incase you want to take this patch via some other tree, here is Ack.
> 
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks, probably it's better to merge everything through the arm-soc tree.

Cheers,

-- 
Carlo Caione
