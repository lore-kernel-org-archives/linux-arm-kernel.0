From: peter@korsgaard.com (Peter Korsgaard)
Date: Thu, 10 Jul 2014 16:32:21 +0200
Subject: [PATCH 09/16] i2c: i2c-ocores: Drop class based scanning to
 improve bootup time
In-Reply-To: <1404992799-3705-10-git-send-email-wsa@the-dreams.de> (Wolfram
 Sang's message of "Thu, 10 Jul 2014 13:46:29 +0200")
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
 <1404992799-3705-10-git-send-email-wsa@the-dreams.de>
Message-ID: <874mypp9my.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

 > This driver has been flagged to drop class based instantiation. The removal
 > improves boot-up time and is unneeded for embedded controllers. Users have been
 > warned to switch for some time now, so we can actually do the removal. Keep the
 > DEPRECATED flag, so the core can inform users that the behaviour finally
 > changed now. After another transition period, this flag can go, too.
 > While we are here, remove the indentation for the array setup because
 > such things always break after some time.

 > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
