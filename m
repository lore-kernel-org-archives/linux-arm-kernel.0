From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 15 May 2014 23:14:13 +0200
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
Message-ID: <53752E25.9060604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chirantan,

On 15.05.2014 23:07, Chirantan Ekbote wrote:
> The multi core timer and the ARM architected timer are two different
> interfaces to the same underlying hardware timer.  This causes some
> strange timing issues when they are both enabled at the same time so
> remove the mct from the device tree and keep only the architected
> timer.

Huh? I've always thought MCT is a completely separate hardware block
outside of ARM cores, while architected timers are embedded inside the
CPU block in which the ARM cores reside. Could you elaborate on this?

Best regards,
Tomasz
