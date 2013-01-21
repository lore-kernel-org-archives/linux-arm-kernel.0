From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jan 2013 17:59:27 +0000
Subject: [PATCH 2/6] clocksource: time-armada-370-xp: add local timer
 support
In-Reply-To: <1358790842-2986-3-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130121175927.GV23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 06:53:58PM +0100, Gregory CLEMENT wrote:
> +struct clock_event_device __percpu **percpu_armada_370_xp_evt;
> +

Have you run this through checkpatch?  Should the above be static?
