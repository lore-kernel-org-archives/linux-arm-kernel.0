From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Tue, 15 Apr 2014 10:37:25 +0530
Subject: [PATCH V4 1/5] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <534BEEED.1060309@samsung.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
 <534529B2.2020107@samsung.com> <534BCC91.8090108@ti.com>
 <CAFp+6iGxhfgZRPysMuj5nALEQBbFXnAXhtDPpbf3P42LDHqFxg@mail.gmail.com>
 <534BDD17.60003@ti.com> <534BE658.8050606@gmail.com>
 <CAFp+6iHhUvLhAKGPARS8RUfmO8RGcTrumvYb7QjJXbFD1nUuig@mail.gmail.com>
 <534BEEED.1060309@samsung.com>
Message-ID: <CAFp+6iFQes3xSj7V7a0sCPaD1oXNccgp3j5ZNNPUqJPXHu9OSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,


On Mon, Apr 14, 2014 at 7:51 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 14/04/14 15:49, Vivek Gautam wrote:
>> True, we don't have a scope of instantiating this driver using old
>> platform device and
>> old legacy board files.
>> So we don't need this check then, right ?
>
> I think it can be dropped.
> At least IMHO there is no point to increase size of the module with
> an error log that has no chance to be ever called in practice.

Ok, i will remove this error message and in fact this check.



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
