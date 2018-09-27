From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 27 Sep 2018 11:56:54 -0300
Subject: [PATCH] ARM: dts: vf610: Add ZII SCU4 AIB board
In-Reply-To: <20180927143324.GA12979@lunn.ch>
References: <1538054166-28411-1-git-send-email-festevam@gmail.com>
 <20180927143324.GA12979@lunn.ch>
Message-ID: <CAOMZO5CCSrHivM2fiAy-A7H5jEMutQQHXuaac0Tn-QBuW3oKSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Sep 27, 2018 at 11:33 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Sep 27, 2018 at 10:16:06AM -0300, Fabio Estevam wrote:
>> Add support for the ZII SCU 4 board, which has lots of switches and
>> SFF ports.
>>
>> Based on the work from Andrew Lunn.
>
> Hi Fabio
>
> This is not my version. It does not make use of sfp devices. The
> properties listed here for SFP are proprietary to ZII kernel code, not
> mainline. This file is not suitable for mainline.

Ops, sorry, I based on the wrong version.

Will rework it and send a v2.

Thanks!
