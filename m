From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 13 Nov 2013 19:15:49 +0800
Subject: [PATCH 0/2] ARM & scripts: fix kallsyms regression
Message-ID: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches fix the regression on !MMU by below commit:

f6537f2f0eba4eba("scripts/kallsyms: filter symbols not
in kernel address space")

Thanks,
--
Ming Lei
