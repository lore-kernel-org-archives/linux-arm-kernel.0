From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 14 Mar 2013 10:30:18 -0700 (PDT)
Subject: [PATCH v2 4/8] drivers: input: use module_platform_driver_probe()
In-Reply-To: <1363280978-24051-5-git-send-email-fabio.porcedda@gmail.com>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-5-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <3681471.ufqahH3gTF@dtor-d630.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thursday, March 14, 2013 06:09:34 PM Fabio Porcedda wrote:
> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.

I already have patches from Sachin Kamat for this, I am waiting for -rc3
to sync up with mainline and pick up the macro before applying them.

Thanks.

-- 
Dmitry
