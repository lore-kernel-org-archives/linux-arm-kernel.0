From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 10:01:32 +0100
Subject: [PATCH v3 09/13] ARM: dts: armada-375: Fixup soc DT warning
In-Reply-To: <20161118095455.00bfe007@free-electrons.com> (Thomas Petazzoni's
 message of "Fri, 18 Nov 2016 09:54:55 +0100")
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
 <20161117230830.31047-10-gregory.clement@free-electrons.com>
 <20161118095455.00bfe007@free-electrons.com>
Message-ID: <87d1htb1qr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., nov. 18 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Fri, 18 Nov 2016 00:08:26 +0100, Gregory CLEMENT wrote:
>
>> -	soc {
>> +	/* The following unit address is composed of the target
>> +	 * value (bit [40-47]), attributes value (bits [32-39],
>> +	 * and the address value in the window memory: [0-31].
>> +	 */
>> +	soc at f00100000000 {
>
> Where is this value coming from? Why does the soc node needs to have a

It cames from the dts files.

> unit address? It doesn't have a 'reg' property if I remember
> correctly.

But it has a range property.

Gregory

>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
