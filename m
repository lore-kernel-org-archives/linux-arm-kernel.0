From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Tue, 15 Aug 2017 09:11:43 +0100
Subject: [PATCH 01/11] ASoC: codecs: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-2-git-send-email-bhumirks@gmail.com>
Message-ID: <20170815081143.cpkronjaqjo5ike5@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 05:08:40PM +0530, Bhumika Goyal wrote:
> Make these const as they are either passed as the 2nd argument to the
> function devm_snd_soc_register_platform or snd_soc_register_platform,
> and the arguments are of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

For the Wolfson bits:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
