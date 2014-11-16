From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 13:34:10 +0100
Subject: [PATCHv1 1/3] arm: mvebu: add uartX labels for Armada SoC serial
 nodes
In-Reply-To: <20141116010933.GB15870@lunn.ch> (Andrew Lunn's message of "Sun,
 16 Nov 2014 02:09:33 +0100")
References: <cover.1416095841.git.arno@natisbad.org>
 <ee5646b8e097b266f51a68f489644256d7c3df33.1416095841.git.arno@natisbad.org>
 <20141116010933.GB15870@lunn.ch>
Message-ID: <87h9xzb9z1.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Andrew Lunn <andrew@lunn.ch> writes:

> On Sun, Nov 16, 2014 at 01:04:12AM +0100, Arnaud Ebalard wrote:
>> 
>> This patch adds uartX labels for Armada SoC serial nodes. This is
>> a preliminary work to be able to easily reference the serial lines
>> in Device Tree files. One expected future use is when providing
>> stdout-path property for barebox.
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>
> Acked-by: Andrew Lunn <andrew@lunn.ch>
>
> Not a must, but it would be nice to make use of these in
> armada-xp-lenovo-ix4-300d.dts, which currently has:
>
>       	     stdout-path = "/soc/internal-regs/serial at 12000";

Will add a patch to the series to do that.

Thanks.

a+
