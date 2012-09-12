From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 12 Sep 2012 09:30:24 -0700
Subject: [PATCH] hwmon: (sht15) move header to linux/platform_data/
In-Reply-To: <1347467024-3231-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1347467024-3231-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Message-ID: <20120912163024.GA23096@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 12:23:44PM -0400, Vivien Didelot wrote:
> This patch moves the sht15.h header from include/linux to
> include/linux/platform_data, and update existing support (stargate2
> platform) accordingly.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next, and fixed:

/home/groeck/src/linux-staging/.git/rebase-apply/patch:80: new blank line at
EOF.
+
warning: 1 line adds whitespace errors.

Guenter
