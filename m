From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Apr 2013 10:49:31 +0300
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <20130419171318.GK10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
Message-ID: <20130422074931.GH10536@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 19, 2013 at 10:13:19AM -0700, Tony Lindgren wrote:
> 2. MUSB fails with legacy booting and DT on panda es
> 
> With both legacy and DT booting I get something like:
> 
> HS USB OTG: no transceiver configured
> musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517

well, enable a transceiver :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/a4fac839/attachment.sig>
