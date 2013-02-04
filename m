From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 04 Feb 2013 09:58:33 +0100
Subject: [PATCH 0/2] ARM: dts: OMAP3: Add GPMC controller and NAND memory
 to Overo
In-Reply-To: <20130201221618.GB22517@atomide.com>
References: <1359395648-2137-1-git-send-email-florian.vaussard@epfl.ch>
 <20130201221618.GB22517@atomide.com>
Message-ID: <510F7839.9040603@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> So how should we handle such case? Having several dtsi depending
>> on the Overo's revision would be a mess to my sense, considering
>> the non-conditional include inside the expansion boards' dts.
>> Or would it make sense to extend the DT binding for partitions?
>
> Yes makes sense to extend the binding to use the full flash memory
> if the size can be probed.
>

Ok, I will see for a patch soon (i.e. in the coming weeks).

Regards,

Florian
