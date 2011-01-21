From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 20 Jan 2011 19:43:23 -0800
Subject: Locking in the clk API
In-Reply-To: <20110120185707.GJ6335@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111031552.GJ3760@linux-sh.org>	<201101111211.30172.jeremy.kerr@canonical.com>	<20110111045423.GP3760@linux-sh.org>
	<4D3863AC.4020209@fluff.org>
	<20110120185707.GJ6335@n2100.arm.linux.org.uk>
Message-ID: <4D3900DB.8090401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 10:57 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 20, 2011 at 04:32:44PM +0000, Ben Dooks wrote:
>> I would vote for all clk lookup and reference counting code be made
>> sleep-able and define it as such.
>
> Always has been and probably always will be.
>

clk_enable/disable APIs have refcounting and they certainly aren't 
sleep-able. I'm not sure if that's what Ben meant though.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
