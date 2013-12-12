From: cjb@laptop.org (Chris Ball)
Date: Wed, 11 Dec 2013 20:39:36 -0500
Subject: mmc: mxs: Use mmc_of_parse
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de> (Sascha
 Hauer's message of "Thu, 5 Dec 2013 14:34:45 +0100")
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87y53q6e5j.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Dec 05 2013, Sascha Hauer wrote:
> We have a generic mmc_of_parse function. Use it in the mxs-mmc driver
> to make the code simpler and to parse some new devicetree propeties.

Great, thanks for doing this; all six patches pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
