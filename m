From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Feb 2013 10:36:02 +0000
Subject: [PATCH 04/12] clocksource: samsung-time: Move samsung-time.h
 header to include/linux
In-Reply-To: <1360502423-2246-5-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
 <1360502423-2246-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130211103602.GB32455@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 01:20:15PM +0000, Tomasz Figa wrote:
> This patch moves the samsung-time.h header file to include/linux
> directory and fixes all references to it.

Perhaps include/clocksource would be better?

Thanks,
Mark.
