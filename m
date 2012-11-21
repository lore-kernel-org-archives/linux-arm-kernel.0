From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 13:35:45 +0100
Subject: [GIT PULL] Marvell Ethernet driver clk support + section
 mismatch fix
In-Reply-To: <1353334396-26128-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353334396-26128-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121121133545.1a45263c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Mon, 19 Nov 2012 15:13:14 +0100, Thomas Petazzoni wrote:

>  * One adding clk support. It's not a fix, but I think it's better if
>    we can get the Device Tree binding correct directly in 3.8. This
>    commit basically replaces the clock-frequency DT property by a
>    proper 'clocks' DT property that references a DT clock. If we don't
>    get this in 3.8, we'll have to support the legacy clock-frequency
>    DT property for ever as it will be part of the kernel-to-DT ABI. So
>    it would be nicer to get this patch in for 3.8.
> 
>    The DT patches related to this one are coming into a separate pull
>    request.
> 
>  * The second one fixes a section mismatch warning, so it is certainly
>    important.

Do you agree with those two changes? If so, shall we carry them with
the rest of the mvneta driver through arm-soc with your Acked-by?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
