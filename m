From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Sun, 1 Jul 2018 14:18:52 +0300
Subject: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
In-Reply-To: <20180627005523.GS129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-5-georgi.djakov@linaro.org>
 <20180627005523.GS129942@google.com>
Message-ID: <185ab8a2-f4e5-dd4f-6446-44ab7fddf12e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 06/27/2018 03:55 AM, Matthias Kaehlcke wrote:
> On Wed, Jun 20, 2018 at 03:11:37PM +0300, Georgi Djakov wrote:
>> On some Qualcomm SoCs, there is a remote processor, which controls some of
>> the Network-On-Chip interconnect resources. Other CPUs express their needs
>> by communicating with this processor. Add a driver to handle comminication
> 
> s/comminication/communication/
> 

[..]

>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RPM over SMD communication wrapper for interconects
> 
> s/interconects/interconnects/
> 

Thanks, will fix them!

BR,
Georgi
