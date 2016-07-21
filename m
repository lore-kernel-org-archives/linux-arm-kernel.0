From: mirza.krak@gmail.com (Mirza Krak)
Date: Thu, 21 Jul 2016 23:41:56 +0200
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <222d4179-a72f-56d1-246b-ab66af3057d9@nvidia.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
 <222d4179-a72f-56d1-246b-ab66af3057d9@nvidia.com>
Message-ID: <CALw8SCV9ZV+OpuVz3r2dXGb55mC26es-Oe7HfZRCJgyxONRqTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-21 17:12 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>
> The reset is defined in the binding, but never used. Should we make sure
> the reset is de-asserted in the probe?

Yes, will do that.
