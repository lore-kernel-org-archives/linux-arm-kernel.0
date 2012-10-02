From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 02 Oct 2012 15:08:00 -0700
Subject: [PATCH] ARM: OMAP: hwmod: align the SmartReflex fck names
In-Reply-To: <87626s8rys.fsf@deeprootsystems.com>
References: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
 <1348497352-6464-1-git-send-email-j-pihet@ti.com>
 <87626s8rys.fsf@deeprootsystems.com>
Message-ID: <506B65C0.7070902@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2012 02:49 PM, Kevin Hilman wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Rename the smartreflex fck names for consistency and better readability;
>> rename the clock aliases for use by the SmartReflex driver, with the
>> "smartreflex.%d" format.
>
> hmm, do we even need the clkdev nodes anymore?  The driver isn't
> directly accessing the fclk at all, so it seems like these could be
> removed now.

Please ignore this comment, I see what you're doing in the other series 
now.  See my comments there.

Kevin
