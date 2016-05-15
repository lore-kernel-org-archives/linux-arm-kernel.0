From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Sun, 15 May 2016 06:05:01 +0200
Subject: [PATCH] clk: ti: Add support for basic clk_set_rate for dm814x
 and j5-eco ADPLL
In-Reply-To: <20160515040028.GA20983@squirrel.local>
References: <1463157653-9404-1-git-send-email-tony@atomide.com>
 <20160515040028.GA20983@squirrel.local>
Message-ID: <20160515040501.GB20983@squirrel.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 15, 2016 at 06:00:28AM +0200, Matthijs van Duin wrote:
> /*12*/  u16 postdiv;    // aka M2       1..31   1..127  (but see note below)
> /*14*/  u16 mult;       // aka M        2..2047 2..4095

I just noticed that should have been

> /*12*/  u16 postdiv;    // aka M2       1..31   1..127
> /*14*/  u16 mult;       // aka M        2..2047 2..4095 (but see note below)

obviously :)
