From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 22:02:48 +0200
Subject: [PATCH 4/7] drm/panel: Add Sinlinx SinA33 7" panel
In-Reply-To: <66681473008583@web28j.yandex.ru>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-5-maxime.ripard@free-electrons.com>
 <66681473008583@web28j.yandex.ru>
Message-ID: <20160905200248.GB8596@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 05, 2016 at 01:03:03AM +0800, Icenowy Zheng wrote:
> Hi Everyone,
> 
> 01.09.2016, 23:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > ?The SinA33 has an unidentified panel. Add the timings for it under a new
> > ?compatible.
> 
> 
> 
> Excuse me...
> I will ask a question which is not fully related to the patch here...
> If I want to add a generic panel for Q8 tablets, what should it be called?
> "allwinner,q8-lcd-panel-800x480"?

I guess it's more of a question for Thierry, but it seems like the
trend is to put the diagonal rather than the resolution in the
compatibles.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/29fbffe6/attachment-0001.sig>
