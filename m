From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 6 Nov 2015 15:30:57 +0000
Subject: [PATCH 5/7] crypto: picoxcell: check return value of
 sg_nents_for_len
In-Reply-To: <1446668045-8620-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1446668045-8620-1-git-send-email-clabbe.montjoie@gmail.com>
 <1446668045-8620-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151106153057.GA10738@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 09:13:37PM +0100, LABBE Corentin wrote:
> The sg_nents_for_len() function could fail, this patch add a check for
> its return value.
> In the same time, we remove sg_count() as it is used as an alias of
> sg_nents_for_len.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>

thanks for doing this!

Jamie
