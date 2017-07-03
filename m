From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Mon, 3 Jul 2017 10:16:31 +0100
Subject: [PATCH v3 10/12] ASoC: wm9705: add private structure
In-Reply-To: <20170630194408.24978-11-robert.jarzmik@free.fr>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-11-robert.jarzmik@free.fr>
Message-ID: <20170703091631.h2e53k4sgvofdlbl@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 09:44:06PM +0200, Robert Jarzmik wrote:
> Add a private data structure. This is a preparation for a codec which
> would need an another data on top of snd_ac97, which will be the case
> when an MFD wm97xx device will probe wm9705.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
