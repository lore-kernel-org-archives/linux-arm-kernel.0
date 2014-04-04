From: keescook@chromium.org (Kees Cook)
Date: Thu,  3 Apr 2014 19:15:17 -0700
Subject: [RFC PATCH] ARM: mm: implement CONFIG_DEBUG_RODATA
Message-ID: <1396577719-14786-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the next round of trying to implement RODATA. This series works
for the page tables, but I can't make ftrace work. I would love to know
what I should fix here. :)

Thanks to everyone who's been helping with this series!

-Kees
