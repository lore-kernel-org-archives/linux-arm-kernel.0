From: cliff.brake@gmail.com (Cliff Brake)
Date: Tue, 6 Aug 2013 12:08:35 -0400
Subject: kernel mode splash screen
Message-ID: <CAOd_LFxfwdD3afK3QaExsZNV_KsBPQiUEVuewF1VWHUEovOPPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We are working on an embedded system where we need immediate feedback
on the screen in response to power button events, etc.  We also need
to be able to display the splash screen whenever kernel is running.
User space splash screens get killed too early on shutdown, etc.

Does anyone know of a kernel mode splash screen that will:

1) display an image
2) display status messages
3) display progress bar (nice to have, but not required)
4) can be accessed from kernel and user space
5) when enabled, will disable writes from user space
6) FB based

Thanks,
Cliff

-- 
=================
http://bec-systems.com
