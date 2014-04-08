From: keescook@chromium.org (Kees Cook)
Date: Mon,  7 Apr 2014 20:15:08 -0700
Subject: [PATCH v2] ARM: mm: implement CONFIG_DEBUG_RODATA
Message-ID: <1396926910-11227-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements CONFIG_DEBUG_RODATA, along with ftrace support. It is
intended to be used on top of Rabin Vincent's patch "arm: ftrace: work
with CONFIG_DEBUG_SET_MODULE_RONX", so that ftrace will work with both
config options.

Thanks!

-Kees
