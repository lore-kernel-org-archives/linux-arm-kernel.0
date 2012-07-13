From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 13 Jul 2012 17:41:45 -0600 (MDT)
Subject: [RFC RESEND 4/4] ARM: OMAP: Add DT support for timer driver
In-Reply-To: <1342218413-30116-5-git-send-email-jon-hunter@ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-5-git-send-email-jon-hunter@ti.com>
Message-ID: <alpine.DEB.2.00.1207131740460.25585@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 13 Jul 2012, Jon Hunter wrote:

> 1. If DT blob is present, then let HWMOD create the timer devices dynamically.

This probably should read "is _not_ present", yes?


- Paul
