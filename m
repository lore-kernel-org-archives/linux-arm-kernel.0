From: robherring2@gmail.com (Rob Herring)
Date: Tue, 21 Dec 2010 08:14:57 -0600
Subject: [PATCH v2 2/3] ARM: timer-sp: support timer clock freq other
	than 1MHz
In-Reply-To: <20101221134443.GA1556@n2100.arm.linux.org.uk>
References: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
	<1286030086-25556-3-git-send-email-robherring2@gmail.com>
	<20101221134443.GA1556@n2100.arm.linux.org.uk>
Message-ID: <4D10B661.6070809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2010 07:44 AM, Russell King - ARM Linux wrote:
> On Sat, Oct 02, 2010 at 09:34:45AM -0500, Rob Herring wrote:
>> From: Rob Herring<rob.herring@smooth-stone.com>
>>
>> The timer-sp code is fixed to 1MHz timer clock. Add clock api
>> calls to get the timer clock frequency and support for independent
>> clock frequencies.
>>
>> Rename timer names for clocksource and clockevent to timer-sp or
>> the clock connection ID string if provided.
>>
>> Signed-off-by: Rob Herring<rob.herring@smooth-stone.com>
>
> As mentioned in the previous few days on the mailing list, rather than
> having this code half-heartedly use the clk API, I'd much rather we did
> a proper conversion.  That means having the clk API up and running
> earlier than we currently do on the ARM platforms.
>
> In order to allow this to happen, I've queued an addition to the mdesc
> record which provides an early hook which can be used for this kind of
> early platform initialization.
>
> So, after the next merge window, could you have another look at this
> please?

Sure, no problem.

Rob
