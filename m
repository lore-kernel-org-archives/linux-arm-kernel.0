From: mmarek@suse.cz (Michal Marek)
Date: Thu, 02 Apr 2015 17:27:49 +0200
Subject: [PATCH 0/4] kbuild: refactor Makefile inclusion
In-Reply-To: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
References: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <551D5FF5.7070503@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-27 12:43, Masahiro Yamada wrote:
> Masahiro Yamada (4):
>   kbuild: use relative path to include Makefile
>   kbuild: use relative path more to include Makefile
>   kbuild: include $(src)/Makefile rather than $(obj)/Makefile
>   kbuild: ia64: use $(src)/Makefile.gate rather than particular path

Applied to kbuild.git#kbuild.

Michal
