From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 16 Apr 2014 13:19:40 +0200
Subject: [PATCH] ARM i.MX51: Add Efika MX Smartbook devicetree
In-Reply-To: <1397641298-25392-1-git-send-email-shc_work@mail.ru> (Alexander
 Shiyan's message of "Wed, 16 Apr 2014 13:41:38 +0400")
References: <1397641298-25392-1-git-send-email-shc_work@mail.ru>
Message-ID: <87tx9to71v.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shiyan <shc_work@mail.ru> writes:

> This patch adds support for Efika MX Smartbook.

I'm curious, how did you test that ? From a very quick look,
seems it has no chance to work with the uboot shipped with the devices.

What about the  mtl017 ? do you have a driver ready to be submitted
mainline ?

Arnaud
