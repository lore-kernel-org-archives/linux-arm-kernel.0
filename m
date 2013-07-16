From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Jul 2013 14:13:32 +0100
Subject: [PATCH v3] rtc: Add MOXA ART RTC driver
In-Reply-To: <1373978485-17496-1-git-send-email-jonas.jensen@gmail.com>
References: <1373550711-18828-1-git-send-email-jonas.jensen@gmail.com>
 <1373978485-17496-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130716131332.GL22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 02:41:25PM +0200, Jonas Jensen wrote:

>     1. don't use hardcoded GPIO numbers, use of_get_named_gpio

Since you're now using OF you should also be including a binding
document.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/e65a6be3/attachment-0001.sig>
