From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 05 Mar 2015 13:18:54 +0100
Subject: parent/child hierarchy for regulator
In-Reply-To: <20150305103534.GA19600@shlinux2>
References: <20150305103534.GA19600@shlinux2>
Message-ID: <54F849AE.6040104@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am 05.03.2015 um 11:35 schrieb Peter Chen:
> Hi lists,
>
> Any good ways at code/dts to show parent/child hierarchy for regulator?
>
> The related regulators at my platforms like below:
> PMIC (SWB 5v) --> Switch Chip (GPIO Regulator) --> USB VBUS
>
> PMIC has one 5V regulator (eg, swbst at pfuse), and it is the input
> for USB power switch chip, and there are two gpios at this switch
> chip to control if 5V is output or not, we register these two gpios as 
> fixed regulators, currently, if regulator swbst is disabled, the
> gpio regulator has no way to know, and cause the vbus voltage is wrong.
>
> Thanks in advance.
>

i don't have an answer to your question, but do you think of i.MX28
platform?

Regards
Stefan
