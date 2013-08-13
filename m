From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 13 Aug 2013 11:53:13 -0400 (EDT)
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
Message-ID: <alpine.LFD.2.03.1308131151110.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Nicolas Pitre wrote:

> 
> Please pull the following:
> 
> 	git://git.linaro.org/people/nico/linux mcpm+tc2
> 
> which will update your vexpress/mcpm branch with one additional commit 
> fixing the build issue with CONFIG_FRAME_POINTER reported by RMK.  This 
> commit's SHA1 is 95fbdc9cf542.

If you didn't pull this yet, this commit is now 2d61241eb3 as I added 
Dave Martin's reviewed-by tag.


Nicolas
