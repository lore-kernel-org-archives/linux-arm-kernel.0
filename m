From: keescook@chromium.org (Kees Cook)
Date: Thu,  7 Sep 2017 08:30:43 -0700
Subject: [PATCH 0/4] Fix check address limit on user-mode
Message-ID: <1504798247-48833-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes from Thomas Garnier: the new address limit check was causing
hangs on ARM. This solves the problem and takes proactive steps on
ARM64. Additionally removes the unconditional BUG_ON() on check failures.

-Kees
