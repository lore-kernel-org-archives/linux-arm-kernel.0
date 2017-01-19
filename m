From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 16:27:22 -0800
Subject: [PATCH] ARM: Reduce "CPU: shutdown" message to debug level
In-Reply-To: <20170118232029.GU27312@n2100.armlinux.org.uk>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
 <20170118225328.2597-1-f.fainelli@gmail.com>
 <20170118232029.GU27312@n2100.armlinux.org.uk>
Message-ID: <bb23d676-d812-1abe-e432-866e6704e595@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 03:20 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2017 at 02:53:26PM -0800, Florian Fainelli wrote:
>> Similar to c68b0274fb3c ("ARM: reduce "Booted secondary processor"
>> message to debug level"), demote the "CPU: shutdown" pr_notice() into a
>> pr_debug().
> 
> Much better, and thanks for dropping the "performance" argument as well.
> CPU hotplug isn't about performance :)
> 
> Please put this in the patch system, thanks.

Done, #8644, thanks!
-- 
Florian
