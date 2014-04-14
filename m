From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 Apr 2014 16:21:33 +0200
Subject: [PATCH V4 1/5] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <CAFp+6iHhUvLhAKGPARS8RUfmO8RGcTrumvYb7QjJXbFD1nUuig@mail.gmail.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
 <534529B2.2020107@samsung.com> <534BCC91.8090108@ti.com>
 <CAFp+6iGxhfgZRPysMuj5nALEQBbFXnAXhtDPpbf3P42LDHqFxg@mail.gmail.com>
 <534BDD17.60003@ti.com> <534BE658.8050606@gmail.com>
 <CAFp+6iHhUvLhAKGPARS8RUfmO8RGcTrumvYb7QjJXbFD1nUuig@mail.gmail.com>
Message-ID: <534BEEED.1060309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/14 15:49, Vivek Gautam wrote:
> True, we don't have a scope of instantiating this driver using old
> platform device and
> old legacy board files.
> So we don't need this check then, right ?

I think it can be dropped.
At least IMHO there is no point to increase size of the module with
an error log that has no chance to be ever called in practice.

--
Thanks,
Sylwester
