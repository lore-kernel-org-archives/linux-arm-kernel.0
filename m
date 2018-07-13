From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jul 2018 08:02:10 -0300
Subject: [PATCH 1/2] ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line
 pinumx config
In-Reply-To: <CAHQ1cqEXBfs1B6Jr1NvUY6WoyX9oG=0haJpiTLVH7t-37ht10Q@mail.gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
 <20180712023337.30112-2-andrew.smirnov@gmail.com>
 <CAOMZO5DfHqKjF6xykJtoC-aA-ATWM6mCZR0VzPVpSDOt-Fs6bQ@mail.gmail.com>
 <CAHQ1cqEXBfs1B6Jr1NvUY6WoyX9oG=0haJpiTLVH7t-37ht10Q@mail.gmail.com>
Message-ID: <CAOMZO5BGuu7VEHNn61W+33PfJ3eQqLTCy8PrAmCtXvLeC-DhLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 2:15 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I wanted to avoid relying on defaults be it register reset values or
> settings that bootloader left us with. Default value of 0xa5 works,
> but, given how the pin is IRQ_TYPE_LEVEL_HIGH, I though it would be
> better to configure it to have a pulldown. Do you want me to add that
> to commit log?

Yes, that would be nice. Thanks
