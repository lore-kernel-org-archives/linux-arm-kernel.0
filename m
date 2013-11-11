From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 11 Nov 2013 21:53:55 +0100
Subject: [PATCHv2] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <52813F25.40703@gmail.com> (Sebastian Hesselbarth's message of
 "Mon, 11 Nov 2013 21:33:41 +0100")
References: <87bo1qhfnf.fsf@natisbad.org> <52813F25.40703@gmail.com>
Message-ID: <874n7ifyn0.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian.

Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> writes:

>> +			serial at 12000 {
>> +				clocks = <&coreclk 0>;
>> +				status = "okay";
>> +			};
>
> For your possible cleanup later: move clocks = <&coreclk 0> to
> armada-370-xp.dtsi and remove this then.
>
> Also for cleanup later: It would be great if most SoC nodes get
> a node label. That way you can just write:
>
> uart0: { status = "okay" };
>
> without replaying node hierarchy over and over again.

I will keep that in mind for later cleanups. Regarding the nits, as you
took the time to report those, I will send a v3 fixing them tomorrow.

Cheers,,

a+
