From: tj@kernel.org (Tejun Heo)
Date: Mon, 04 Jan 2010 08:24:53 +0900
Subject: [PATCH] stack2core: show stack message and convert it to core
	file 	when kernel die
In-Reply-To: <20100103151406.20228c3a@infradead.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>	<4B411F14.1040302@kernel.org>	<20100103150134.5bdab023@infradead.org>	<4B412341.2010002@kernel.org>
	<20100103151406.20228c3a@infradead.org>
Message-ID: <4B412745.9070307@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2010 08:14 AM, Arjan van de Ven wrote:
>> Whichever one works but s2c wouldn't require symbol decoding.  Maybe
>> we can simply add an option to tell it to just parse the oops and
>> output it in machine friendly format.  Oh, also, the patch does add
>> new information the module load addresses.  We should be able to add
>> those to the oops message in a compact form.
> 
> actually one does not need those; you know the start address of the
> function already from the current oops output, and since you know the
> address of the function within the module as well, you know the start
> address of the module.

Right.  Thanks for the explanation.

-- 
tejun
