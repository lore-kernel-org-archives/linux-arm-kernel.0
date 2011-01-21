From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 09:31:04 +0000
Subject: Locking in the clk API
In-Reply-To: <4D3900DB.8090401@codeaurora.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
	<201101111211.30172.jeremy.kerr@canonical.com>
	<20110111045423.GP3760@linux-sh.org> <4D3863AC.4020209@fluff.org>
	<20110120185707.GJ6335@n2100.arm.linux.org.uk>
	<4D3900DB.8090401@codeaurora.org>
Message-ID: <20110121093104.GA13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 07:43:23PM -0800, Saravana Kannan wrote:
> On 01/20/2011 10:57 AM, Russell King - ARM Linux wrote:
>> On Thu, Jan 20, 2011 at 04:32:44PM +0000, Ben Dooks wrote:
>>> I would vote for all clk lookup and reference counting code be made
>>> sleep-able and define it as such.
>>
>> Always has been and probably always will be.
>>
>
> clk_enable/disable APIs have refcounting and they certainly aren't  
> sleep-able. I'm not sure if that's what Ben meant though.

Ben's talking about clk_get/clk_put.  See "clk lookup" in his sentence.
