From: cjb@laptop.org (Chris Ball)
Date: Fri, 12 Apr 2013 14:14:00 -0400
Subject: [PATCH] mmc: mxcmmc: Fix bug when card is present during boot
In-Reply-To: <20130409073318.GF1906@pengutronix.de> (Sascha Hauer's message of
 "Tue, 9 Apr 2013 09:33:18 +0200")
References: <1365228811-10928-1-git-send-email-shc_work@mail.ru>
 <20130409073318.GF1906@pengutronix.de>
Message-ID: <87bo9jfwgn.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 09 2013, Sascha Hauer wrote:
> On Sat, Apr 06, 2013 at 10:13:31AM +0400, Alexander Shiyan wrote:
>> This patch fixes bug when card is present during boot.
>> Bug was introduced due commit "mmc: mxcmmc: fix bug that may block a
>> data transfer forever". When a card is present "mxcmci_setup_data"
>> function is executed, but the timer is not initialized.
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
