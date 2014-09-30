From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 30 Sep 2014 15:30:00 -0700
Subject: [PATCH v7 00/11] kernel: Add support for restart handler call
 chain
In-Reply-To: <20140930142002.e09ef32392a2b5a7c81e5e57@linux-foundation.org>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <20140930142002.e09ef32392a2b5a7c81e5e57@linux-foundation.org>
Message-ID: <20140930223000.GA20946@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 02:20:02PM -0700, Andrew Morton wrote:
> On Tue, 19 Aug 2014 17:45:27 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Introduce a system restart handler call chain to solve the described problems.
> 
> So someone has merged eight of these patches into linux-next but these
> three:
> 
> watchdog-s3c2410-add-restart-handler.patch
> clk-samsung-register-restart-handlers-for-s3c2412-and-s3c2443.patch
> clk-rockchip-add-restart-handler.patch
> 
> were omitted.  What's up?

Most likely PBKC on my side; Looks like I forgot to add those when I created
the immutable branch for others to merge. Sorry for that :-(.

Having said that, I somehow thought that the clock patches would go in through
the clock tree. Heiko, did I get that wrong ? Separately, I sent a pull request
that includes the watchdog patch to Wim.

Thanks,
Guenter
