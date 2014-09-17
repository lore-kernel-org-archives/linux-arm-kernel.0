From: davidcdueck@googlemail.com (D. Dueck)
Date: Wed, 17 Sep 2014 12:11:38 +0200
Subject: [PATCH] can: at91_can: prepare and unprepare the clock
In-Reply-To: <54195097.1000106@pengutronix.de>
References: <1410944721-32325-1-git-send-email-davidcdueck@googlemail.com>
 <54195097.1000106@pengutronix.de>
Message-ID: <CANfhG651svVhhLch9ekjSESTgoS3-0rB1C9RJLkX_=Y=GKOxbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-17 11:12 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:

> Which warning?

I will rephrase this. When using COMMON_CLK, for example on sama5d3, we
have to prepare the clock first. I will send v2.

> Can you please check the return value of clock_prepare_enbale().

Yes, sorry I missed that.

David
