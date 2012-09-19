From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 19 Sep 2012 11:34:17 +0300
Subject: [PATCH v4 00/14] MFD/ASoC/Input: twl4030-audio submodule DT
 support
In-Reply-To: <20120919002439.GB3647@sortiz-mobl>
References: <1347273992-9107-1-git-send-email-peter.ujfalusi@ti.com>
 <20120919002439.GB3647@sortiz-mobl>
Message-ID: <50598389.6020600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On 09/19/2012 03:24 AM, Samuel Ortiz wrote:
> Hi Peter,
> 
> On Mon, Sep 10, 2012 at 01:46:18PM +0300, Peter Ujfalusi wrote:
>> Hello,
>>
>> Generated on top of:
>> git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/omap
> I applied the first 8 patches, but I'd like to get Mark's ACK for the rest of
> the serie.
> Unless you're expecting Mark to take the whole thing, in which case you can
> add my:
> 
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> 
> to the MFD patches.
> Please let me know how you'd like to proceed.

If Mark is still OK with it I think it would be better to queue this series
via ASoC so we can keep them in one place (also I think patch 14 needs patch 6
in order to not break x86/x86_64 allmodconfig).
On the other hand if they go separately (1-8 via MFD, 9-14 via ASoC) they will
meet in linux-next where this matters the most.

Thank you,
P?ter
