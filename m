From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 19 Mar 2014 14:15:51 +0100
Subject: [PATCH v3 2/3] mfd: sec-core: Add of_compatible strings for clock
 MFD cells
In-Reply-To: <20140318203159.GW25478@lee--X1>
References: <1395047958-17953-1-git-send-email-k.kozlowski@samsung.com>
 <1395047958-17953-3-git-send-email-k.kozlowski@samsung.com>
 <20140318203159.GW25478@lee--X1>
Message-ID: <1395234951.7642.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-18 at 20:31 +0000, Lee Jones wrote:
> > Add of_compatible strings for S5M8767 and S2MPS14 clock MFD cells.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/mfd/sec-core.c |    3 +++
> >  1 file changed, 3 insertions(+)
> 
> Applied with Tomasz' Reviewed-by.

Thanks! One minor thing - I see that Tomasz' Review-by got lost when the
patch was applied to your tree:
https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=09f8c0a07044bb8ac5085fcbcf82468173a1666d.

Best regards,
Krzysztof
