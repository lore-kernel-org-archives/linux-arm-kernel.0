From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Jan 2013 11:16:55 +0100
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
In-Reply-To: <50EA9E10.7080605@ti.com>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch>
 <50E6A378.90503@ti.com> <50E6F6AA.4000905@lunn.ch>
 <50EA9E10.7080605@ti.com>
Message-ID: <20130107101655.GS3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> OK. Please put me on Cc so I will keep the review.
> 
> >We differentiate between the different SoCs by DT. Each has its own
> >.dtsi file and we will put the node into only those which have the
> >hardware.
> 
> Ok. That I understand, but my question was more into the difference
> between 88F6282 and 88F6283. Do you need to differentiate those two?

Hi Eduardo

No, there is no need to differentiate between these. As far as the
temperature sensor goes, they are identical. I've been testing on a
88F6282 and Nobuhiro Iwamatsu on a 88F6283.

	    Andrew
