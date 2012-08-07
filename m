From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 7 Aug 2012 14:40:46 +0000
Subject: [PATCH v3] i2c: omap: switch over to autosuspend API
In-Reply-To: <1344343087-8947-1-git-send-email-balbi@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EB3087D@DBDE01.ent.ti.com>
 <1344343087-8947-1-git-send-email-balbi@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB30BDA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 18:08:07, Balbi, Felipe wrote:
> this helps us reduce unnecessary pm transitions
> in case we have another i2c message starting soon.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

FWIW, Acked-by: Vaibhav Bedia <vaibhav.bedia@ti.com> 
