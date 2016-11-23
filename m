From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Wed, 23 Nov 2016 16:13:31 +0200
Subject: [PATCH 1/2] i2c: designware: report short transfers
In-Reply-To: <20161121103200.GG1446@lahna.fi.intel.com>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
 <20161121103200.GG1446@lahna.fi.intel.com>
Message-ID: <a42061c7-22fd-d897-ffb3-946812c0761f@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.11.2016 12:32, Mika Westerberg wrote:
> On Fri, Nov 18, 2016 at 07:40:04PM +0000, Russell King wrote:
>> Rather than reporting success for a short transfer due to interrupt
>> latency, report an error both to the caller, as well as to the kernel
>> log.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
