From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 17:16:02 +0200
Subject: [GIT PULL 1/2] arm64: X-Gene driver updates queued for 4.9
In-Reply-To: <CADaLNDnbuQWrV6myasn2k5Mi7=jdg7FAjbdbS3GrbXY34cBfNA@mail.gmail.com>
References: <CADaLNDnbuQWrV6myasn2k5Mi7=jdg7FAjbdbS3GrbXY34cBfNA@mail.gmail.com>
Message-ID: <2486289.RAhdMoiQln@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 12:01:26 AM CEST Duc Dang wrote:
> This is the driver updates for X-Gene platforms targeted for 4.9.
> 
> The change set includes:
> + X-Gene Soc PMU support patch set from Tai Nguyen (v10 reviewed by
> Mark, DT binding document acked by Rob [1] and was suggested to merge
> via am-soc tree by Will [2])
> 
> As we discussed, the X-Gene Soc PMU will go through arm-soc tree this
> time because we don't have a dedicated tree for PMU drivers yet.
> Starting from v4.10, PMU drivers will be collected by Will/Mark before
> sending to arm-soc tree [3].
> 
> 

Pulled into next/drivers, thanks!

	Arnd
