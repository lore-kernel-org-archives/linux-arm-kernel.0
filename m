From: cjb@laptop.org (Chris Ball)
Date: Fri, 20 Apr 2012 18:59:51 -0400
Subject: [PATCH 5/8] mmc: omap_hsmmc: release correct resource
In-Reply-To: <20120420222305.GI21106@atomide.com> (Tony Lindgren's message of
 "Fri, 20 Apr 2012 15:23:07 -0700")
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRrh-0004bL-3j@rmk-PC.arm.linux.org.uk>
 <20120420222305.GI21106@atomide.com>
Message-ID: <878vhqggbc.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 20 2012, Tony Lindgren wrote:
> * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
>> res can be one of several resources, as this variable is re-used several
>> times during probe.  This can cause the wrong resource parameters to be
>> passed to release_mem_region().
>> 
>> Get the original memory resource before calling release_mem_region().
>> 
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
