From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 May 2013 11:15:36 -0700
Subject: [PATCH] ARM : omap : remove __init for _enable_preprogram
In-Reply-To: <8738tpxwmj.fsf@linaro.org>
References: <1368547621-8570-1-git-send-email-jp.francois@cynove.com>
 <8738tpxwmj.fsf@linaro.org>
Message-ID: <20130516181536.GI5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130514 11:13]:
> jp.francois at cynove.com writes:
> 
> > _enable_preprogram is marked as __init, but is called from _enable which is not.
> > This results in oops once init is freed.
> > Fix this by removing the __init marker.
> >
> > Signed-off-by: Jean-Philippe Fran?ois <jp.francois@cynove.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Tony, this should probably be queued for v3.10-rc, and tagged for stable.

Yes just applied the earlier version of this and added your
ack with cc: stable.

Regards,

Tony
