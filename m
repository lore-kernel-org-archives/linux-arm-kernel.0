From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Wed, 12 Sep 2012 13:17:06 -0400 (EDT)
Subject: [PATCH] hwmon: (sht15) move header to linux/platform_data/
In-Reply-To: <20120912163024.GA23096@roeck-us.net>
Message-ID: <1009769296.403552.1347470226680.JavaMail.root@mail.savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

I didn't notice sht15.h had a blank line at the end.
Maybe this check can be added to the checkpatch.pl script.
Andy, what do you think?

Thanks,
Vivien

----- Mail original -----
De: "Guenter Roeck" <linux@roeck-us.net>
?: "Vivien Didelot" <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors at lm-sensors.org, "Jean Delvare" <khali@linux-fr.org>, "Jonathan Cameron" <jic23@cam.ac.uk>, linux-arm-kernel at lists.infradead.org
Envoy?: Mercredi 12 Septembre 2012 12:30:24
Objet: Re: [PATCH] hwmon: (sht15) move header to linux/platform_data/

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
