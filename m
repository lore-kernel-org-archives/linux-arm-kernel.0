From: omycle@gmail.com (Li Haifeng)
Date: Wed, 10 Apr 2013 17:35:00 +0800
Subject: Kexec couldn't reboot capture kernel on pandaboard ES with OMAP4460
Message-ID: <CAFNq8R5FFUyH+JgjoGc5ctgEfiLvxzi7fzawM7+wFX5nEyTv-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, everyone.

Recently, I try to run kdump on pandaboard ES with omap4460. After
load capture kernel by "kexec -l" and execute "kexec -e", the serial
port output "Starting new kernel" and "Bye", then the system hangs up.

I have tried the upstream Linux Kernel v3.4 and v3.8. All are with this issue.

Could you tell my why and how to solve this issue?

Thanks very much.
