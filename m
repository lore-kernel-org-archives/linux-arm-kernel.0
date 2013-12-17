From: keescook@chromium.org (Kees Cook)
Date: Tue, 17 Dec 2013 14:43:12 -0800
Subject: [PATCH v3] provide -fstack-protector-strong build option
Message-ID: <1387320194-24185-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reorganizes the build options for CONFIG_CC_STACKPROTECTOR so that
the new CONFIG_CC_STACKPROTECTOR_STRONG can be used when building with
a compiler that supports it.

-Kees
