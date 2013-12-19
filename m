From: keescook@chromium.org (Kees Cook)
Date: Thu, 19 Dec 2013 11:35:57 -0800
Subject: [PATCH v5] provide -fstack-protector-strong build option
Message-ID: <1387481759-14535-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reorganizes the build options for CONFIG_CC_STACKPROTECTOR so that
the new CONFIG_CC_STACKPROTECTOR_STRONG can be used when building with
a compiler that supports it.

Now with more help text.

-Kees
