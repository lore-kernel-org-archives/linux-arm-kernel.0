From: luciano.coelho@nokia.com (Luciano Coelho)
Date: Tue, 06 Jul 2010 10:11:29 +0300
Subject: [PATCH 10/15] wireless: wl1271: support return value for the
	set power func
In-Reply-To: <1278376666-3509-11-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-11-git-send-email-ohad@wizery.com>
Message-ID: <1278400289.18287.15.camel@chilepepper>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-06 at 02:37 +0200, ext Ohad Ben-Cohen wrote:
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Make it possible for the set power method to indicate a
> success/failure return value. This is needed to support
> more complex power on/off operations such as bringing up
> (and down) sdio functions.
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> --- 

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>


-- 
Cheers,
Luca.
