From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Oct 2014 16:38:48 +0100
Subject: [PATCH 7/7] ARM: mvebu: Enable perf support in mvebu_v7_defconfig
In-Reply-To: <5447CE55.6020808@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022141127.GN22642@leverpostej>
 <5447CE55.6020808@free-electrons.com>
Message-ID: <20141022153848.GF4010@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >> +CONFIG_PERF_EVENTS=y
> > 
> > Isn't this provided by CONFIG_ARM already?
> > 
> 
> No, you need to select it explicitly, as the other platforms do.

Sorry, I'd misread HAVE_PERF_EVENTS. Apologies for the noise.

Mark.
