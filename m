From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 22:32:09 +0200
Subject: [GIT PULL 2/2] arm64: X-Gene platforms DTS changes queued for 4.9
In-Reply-To: <CADaLNDk7uP8Gv+YB6oJfLqyRgjVVY82jQoPrQMk6y8xXGokyUQ@mail.gmail.com>
References: <CADaLNDk7uP8Gv+YB6oJfLqyRgjVVY82jQoPrQMk6y8xXGokyUQ@mail.gmail.com>
Message-ID: <5369836.4ELrYOmq06@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 12:01:28 AM CEST Duc Dang wrote:
> This is the DTS changes for X-Gene platforms targeted for 4.9.
> 
> The changes include:
> + X-Gene Soc PMU DTS entry from X-Gene PMU patch set of Tai Nguyen [1]
> + Follow up patch to enable DTS entry for SoC PMU on X-Gene v2
> + Correct PCIe legacy interrupt mode to level-active high
> + DTS entry for X-Gene hwmon (v4 acked by Guenter, DT binding document
> and driver is in linux-next now [2])
> + DTS entries for X-Gene v2 CPU clock from X-Gene PMD clock patch set
> (v3 already accepted by Stephen into clk-next [3])
> 
> 

Pulled into next/dt64, thanks!

	Arnd
