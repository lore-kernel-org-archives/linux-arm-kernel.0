From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 15:10:40 -0700
Subject: [PATCH 04/21] usb: chipidea: Only read/write OTGSC from one place
In-Reply-To: <20160628093606.GA30392@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-5-stephen.boyd@linaro.org>
 <AM4PR04MB213088094DF074BB5CB3DD0689210@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <146705447431.30684.10431147947045016957@sboyd-linaro>
 <20160628093606.GA30392@shlinux2>
Message-ID: <146715184098.31418.17641776902812636110@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-28 02:36:06)
> On Mon, Jun 27, 2016 at 12:07:54PM -0700, Stephen Boyd wrote:
> > 
> > Good catch! Thanks.
> 
> Besides above, please delete the declaration at ci.h.
> 

Done. Thanks.
