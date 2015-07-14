From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Jul 2015 12:57:21 -0300
Subject: [PATCH v2] dts: ls1021a: Add dts nodes for eTSEC0,
 eTSEC1 and eTSEC2
In-Reply-To: <1436888777-29742-1-git-send-email-claudiu.manoil@freescale.com>
References: <20150713133138.GO23464@tiger>
 <1436888777-29742-1-git-send-email-claudiu.manoil@freescale.com>
Message-ID: <CAOMZO5A2ftfUhioXpSnbGMxiV-fTePgHqk6zj2ysHe2wUY7JFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 12:46 PM, Claudiu Manoil
<claudiu.manoil@freescale.com> wrote:
> This patch adds generic dts nodes for eTSEC0, eTSEC1 and eTSEC2.
>
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
>
> Enable support for the second interrupt group register block
> and the corresponding Rx/Tx/Err interrupt sources, for each
> eTSEC node.  DT binding documentation updates.
>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>

It seems you missed to put Alison in the From field.

You should also put his Signed-off-by tag just before yours.
