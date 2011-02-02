From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  2 Feb 2011 19:59:57 +0300
Subject: [PATCH 0/6] Switch pxa25x_udc devices to use gpio-vbus tranceiver
Message-ID: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa25x_udc driver contains functionality duplicating gpio-vbus tranceiver
functions. Switch all devices, that depend on it, to use gpio-vbus
and (in the last patches) drop related code from pxa25x_udc.
