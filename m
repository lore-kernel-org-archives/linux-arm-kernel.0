From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2017 12:35:40 -0200
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
Message-ID: <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Jan 19, 2017 at 12:13 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> Would it be nice to add a comment about why this was added? Something to
> prevent a cleanup like "remove empty nodes and invalid memory
> configurations".

Do you mean something like this?

/* "chosen" and "memory" nodes are mandatory */
chosen {};
memory { device_type = "memory"; reg = <0 0>; };
