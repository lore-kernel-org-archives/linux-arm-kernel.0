From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Aug 2017 21:57:44 -0700
Subject: [PATCH v4 0/4] thermal: add brcmstb AVS TMON driver
In-Reply-To: <1502429756.2470.9.camel@intel.com>
References: <20170809220257.4234-1-code@mmayer.net>
 <1502429756.2470.9.camel@intel.com>
Message-ID: <F4FCB786-8A5F-49DA-B101-9493EC6D4C4C@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On August 10, 2017 10:35:56 PM PDT, Zhang Rui <rui.zhang@intel.com> wrote:
>On Wed, 2017-08-09 at 15:02 -0700, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>> 
>> This series adds the brcmstb AVS TMON driver.
>> 
>> The driver was originally written by Brian Norris.
>> 
>> This series is also available at
>> https://github.com/mmayer/linux/tree/brcmstb-thermal-4.13-v4.
>> 
>> v1 of this series can be found at https://lkml.org/lkml/2017/6/5/921
>> v2 of this series can be found at https://lkml.org/lkml/2017/7/21/585
>> v3 of this series can be found at https://lkml.org/lkml/2017/7/31/710
>> 
>> Changes since v3:
>> - Rebased on v4.13-rc3 to resolve conflicts in the MAINTAINERS file
>> 
>thanks, will apply this if we have ACK for patch 3 and 4.

You can take patches 1-2 through your tree and I can take patches 3-4 thought the Broadcom ARM/ARM64 pull requests if that works for you, or FWIW:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

-- 
Florian
