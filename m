From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 17 Jul 2012 13:13:03 +0100
Subject: Device tree.
In-Reply-To: <20120717140100.7c0ae90c@skate>
References: <500552C9.4090107@codethink.co.uk> <20120717140100.7c0ae90c@skate>
Message-ID: <500556CF.6030704@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/12 13:01, Thomas Petazzoni wrote:
> You surely want to have a look at CONFIG_ARM_APPENDED_DTB, which does 
> what you want and is already part of the ARM kernel.

Hi, and thanks.

Unless I'm misunderstanding it, thats not quite what I need - although I 
should probably have made my hack depend on it.

I'm using a uImage; The prepending needs to happen to the zImage / Image.

-Ian
