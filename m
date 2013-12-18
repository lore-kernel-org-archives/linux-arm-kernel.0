From: keescook@chromium.org (Kees Cook)
Date: Wed, 18 Dec 2013 10:19:54 -0800
Subject: [PATCH v4] provide -fstack-protector-strong build option
Message-ID: <1387390796-5860-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reorganizes the build options for CONFIG_CC_STACKPROTECTOR so that
the new CONFIG_CC_STACKPROTECTOR_STRONG can be used when building with
a compiler that supports it.

Now with objdump analysis.

-Kees
