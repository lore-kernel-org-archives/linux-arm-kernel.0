From: lznuaa@gmail.com (Frank Li)
Date: Wed, 23 Jan 2013 16:00:55 +0800
Subject: [PATCH 1/2 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <20130123075323.GU1906@pengutronix.de>
References: <1358914330-3768-1-git-send-email-Frank.Li@freescale.com>
 <20130123072635.GO1906@pengutronix.de>
 <CAHrpEqQ3-prqJaCmt1hfOr4GzDVyuRNvko1SCyQZHdALhHkhkw@mail.gmail.com>
 <20130123075323.GU1906@pengutronix.de>
Message-ID: <CAHrpEqRkxr_R4BuWjpRV3yBUOsedqVPdLK3K6+9w4xoUTRHwEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why do you want to make it configurable anyway? So far no other driver
> seems to need this. My suggestion is to make it unconfigurable.
>
> For adding properties like this to the devicetree remember that they
> should be OS agnostic. napi is a implementation detail relevant only
> for Linux. And even Linux may decide to drop napi support in favour for
> something better in the future.
>

Okay, I will remove such config in v2 version.

best regards
Frank Li
